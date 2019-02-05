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
    
    // Booleans for tracking the state of the focus square to prevent animations overriding one another or repeating unnecessarily
    var inAnimation = false
    var isVisible = false
    
    var inPlaceMode = false
    var inSearchMode = false
    var canPlace = false
    
    // The individual components of the focus square
    var segments = [SCNNode]()
    var fill: SCNNode?
    
    // Predefined animations for searching mode
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
        
        // Initialize a yellow material for the outline, and a green one for the fill
        let segmentMaterial = SCNMaterial()
        let fillMaterial = SCNMaterial()
        segmentMaterial.diffuse.contents = UIColor.yellow
        fillMaterial.diffuse.contents = UIColor.green
        
        // Build the focus square and transform it to be flat on the plane
        addHorizontalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dx: 0.1)
        addHorizontalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dx: -0.1)
        addVerticalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dy: 0.1)
        addVerticalSegment(thickness: 0.005, length: 0.2, material: segmentMaterial, dy: -0.1)
        addFill(size: 0.2, material: fillMaterial)
        transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        
        // Call appear() to properly initialize the boolean variables that track state
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
        
        // Set inAnimation to true so any calls to enterSearchMode() or enterPlaceMode() made before this animation completes will fail
        inAnimation = true
        isVisible = true
        
        // An animation that fades in the segments of the node and scales it to full size
        let appear = {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.2
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.2, 0.7, 1.0)
            SCNTransaction.completionBlock = {
                self.inAnimation = false
                self.enterSearchMode() // Once we have rendered the square, enter search mode as the default state
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
        
        // Set all booleans except inAnimation to false to put the square in a default state
        inAnimation = true
        isVisible = false
        inPlaceMode = false
        inSearchMode = false
        canPlace = false
        
        
        // An animation to scale the node down to 1/5th of its size and set the opacity to 0
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
        
        // Reset the color of the segments to be consistent with default state of searching mode
        for segment in segments {
            segment.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        }
        
        SCNTransaction.commit()
    }
    
    func update(location: SCNVector3, foundPlane: Bool, cameraAngle: Float) {
        // Update the position of the node based on the most recent screen center
        let moveAction = SCNAction.move(to: location, duration: 0.1)
        moveAction.timingMode = .easeInEaseOut
        runAction(moveAction)
        
        // If we did not detect any valid planes to place on, enter search mode
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
        
        
        // An animation that turns the square green, scales it to its original size, fades the fill in, and stops the searching animation on completion
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
            self.removeAction(forKey: "pulse")
            self.removeAction(forKey: "spin")
            self.inAnimation = false
            self.canPlace = true
        }
        SCNTransaction.animationDuration = 0.25
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
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
        
        // An animation that causes the fill to disappear, the outline to turn yellow, and the square to grow slightly. Upon completion, the square will start spinning and pulsing
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

