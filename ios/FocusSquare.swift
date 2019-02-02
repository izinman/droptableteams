//
//  FocusSquare1.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/31/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class FocusSquare: SCNNode {
    
    var inAnimation = false
    var isVisible = false
    
    var inPlaceMode = false
    var inSearchMode = false
    var canPlace = false
    
    var segments = [SCNNode]()
    var fill: SCNNode?
    
    let spinAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 1.5))
    let pulseAction: SCNAction = {
        let pulseOutAction = SCNAction.fadeOpacity(to: 0.3, duration: 0.4)
        let pulseInAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.4)
        
        pulseOutAction.timingMode = .easeInEaseOut
        pulseInAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([pulseOutAction, pulseInAction]))
    }()
    
    override init() {
        super.init()
        
        let segmentMaterial = SCNMaterial()
        let fillMaterial = SCNMaterial()
        
        segmentMaterial.diffuse.contents = UIColor.yellow
        fillMaterial.diffuse.contents = UIColor.green
        
        addHorizontalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dx: 0.1)
        addHorizontalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dx: -0.1)
        addVerticalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dy: 0.1)
        addVerticalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dy: -0.1)
        addFill(size: 0.2, material: fillMaterial)
        
        transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        appear()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHorizontalSegment(thickness: CGFloat, length: CGFloat, material: SCNMaterial, dx: Float) {
        let segmentPlane = SCNPlane(width: thickness, height: length)
        segmentPlane.materials = [material]
        
        let segmentNode = SCNNode(geometry: segmentPlane)
        segmentNode.position.x += dx
        segments.append(segmentNode)
        addChildNode(segmentNode)
    }
    
    func addVerticalSegment(thickness: CGFloat, length: CGFloat, material: SCNMaterial, dy: Float) {
        let segmentPlane = SCNPlane(width: length, height: thickness)
        segmentPlane.materials = [material]
        
        let segmentNode = SCNNode(geometry: segmentPlane)
        segmentNode.position.y += dy
        segments.append(segmentNode)
        addChildNode(segmentNode)
    }
    
    func addFill(size: CGFloat, material: SCNMaterial) {
        let fillPlane = SCNPlane(width: size, height: size)
        fillPlane.materials = [material]
        
        let fillNode = SCNNode(geometry: fillPlane)
        fillNode.opacity = 0.0
        fill = fillNode
        addChildNode(fillNode)
    }
    
    func appear() {
        guard !isVisible else { return }
        
        inAnimation = true
        isVisible = true
        
        let appear = {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.2
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.2, 0.7, 1.0)
            SCNTransaction.completionBlock = {
                self.inAnimation = false
                self.enterSearchMode()
            }
            
            for segment in self.segments {
                segment.opacity = 1.0
            }
            self.scale = SCNVector3(1.0, 1.0, 1.0)
            
            SCNTransaction.commit()
        }
        
        // Allow the selection box's disappear animation to finish before rendering the focus square
        runAction(SCNAction.wait(duration: 0.175), completionHandler: appear)
        
    }
    
    func disappear() {
        guard isVisible else { return }
        
        inAnimation = true
        isVisible = false
        inPlaceMode = false
        inSearchMode = false
        canPlace = false
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.15
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.1, 0.5, 1.0)
        SCNTransaction.completionBlock = {
            self.inAnimation = false
        }
        
        scale = SCNVector3(0.2, 0.2, 0.2)
        for node in childNodes {
            node.opacity = 0.0
        }
        
        for segment in segments {
            segment.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        }
        
        SCNTransaction.commit()
    }
    
    func update(location: SCNVector3, foundPlane: Bool, cameraAngle: Float) {
        // Update the position of the node
        let moveAction = SCNAction.move(to: location, duration: 0.1)
        moveAction.timingMode = .easeInEaseOut
        runAction(moveAction)
        
        if !foundPlane {
            enterSearchMode()
        } else {
            // Otherwise, enter place mode and adjust the square to face the camera
            enterPlaceMode()
            adjustAngle(angle: cameraAngle)
        }
    }

    func enterPlaceMode() {
        guard isVisible, !inAnimation, !inPlaceMode else { return }
        
        inAnimation = true
        inPlaceMode = true
        inSearchMode = false
        
        // Square will stop spinning and pulsing once it has returned to placement mode
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
            self.removeAction(forKey: "pulse")
            self.removeAction(forKey: "spin")
            self.inAnimation = false
            self.canPlace = true
        }
        SCNTransaction.animationDuration = 0.25
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // Change the color of the segments to green, rescale and fade the fill in
        for segment in segments {
            segment.geometry?.materials.first?.diffuse.contents = UIColor.green
        }
        scale = SCNVector3(1.0, 1.0, 1.0)
        fill?.opacity = 0.4
        
        SCNTransaction.commit()
    }
    
    func enterSearchMode() {
        // Check to make sure we're in the placement state before transitioning and set it appropriately
        guard isVisible, !inAnimation, !inSearchMode else { return }
        
        inAnimation = true
        inSearchMode = true
        inPlaceMode = false
        canPlace = false
        
        // Square will start spinning and pulsing after entering search mode
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.25
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        SCNTransaction.completionBlock = {
            self.runAction(self.spinAction, forKey: "spin")
            self.runAction(self.pulseAction, forKey: "pulse")
            self.inAnimation = false
        }
        
        // Make the fill disappear, change the color of the segments, and slightly increase the square's size
        fill?.opacity = 0.0
        for segment in segments {
            segment.geometry?.materials.first?.diffuse.contents = UIColor.yellow
        }
        scale = SCNVector3(1.1, 1.1, 1.1)
        
        SCNTransaction.commit()
    }
    
    func adjustAngle(angle: Float) {
        guard eulerAngles.y != angle else { return }
        eulerAngles = SCNVector3(x: eulerAngles.x, y: angle, z: eulerAngles.z)
    }

}

