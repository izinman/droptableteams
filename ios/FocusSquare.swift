//
//  FocusSquare.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class FocusSquare: SCNNode {
    
    // Initialization data for creating the focusSquare
    let size: CGFloat = 0.2
    let segmentWidth: CGFloat = 0.005
    
    private let colorMaterial: SCNMaterial = {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        return material
    }()
    
    private let fill: SCNNode = {
        let square = SCNPlane(width: 0.2, height: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        square.materials = [material]
        
        let tmp = SCNNode(geometry: square)
        tmp.opacity = 0.0
        return tmp
    }()
    
    // Used to track the square's state to run appropriate animations
    var readyToPlace = false
    var isAnimating = false
    
    // Animations to run during searching mode
    private let spinAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 1.5))
    private let pulseAction: SCNAction = {
        let pulseOutAction = SCNAction.fadeOpacity(to: 0.3, duration: 0.4)
        let pulseInAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.4)
        pulseOutAction.timingMode = .easeInEaseOut
        pulseInAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([pulseOutAction, pulseInAction]))
    }()
    
    /* Public init functions
    */
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /* Transition functions
        Update the square's location and angle based on camera movement,
        and enter search mode or placement mode depending on whether ARKit has
        detected an existingPlaneUsingExtent we can place on.
    */
    
    func updateSquare(toLocation: SCNVector3, foundPlane: Bool, cameraAngle: Float) {
        // Update the position of the node
        let moveAction = SCNAction.move(to: toLocation, duration: 0.05)
        moveAction.timingMode = .easeInEaseOut
        runAction(moveAction)
        
        // If we do not have a suitable plane to place on, indiate this to the user by entering search mode
        if !foundPlane {
            enterSearchingMode()
        } else {
            // Otherwise, enter place mode and adjust the square to face the camera
            enterPlacementMode()
            adjustAngle(angle: cameraAngle)
        }
    }
    
    func adjustAngle(angle: Float) {
        guard eulerAngles.y != angle else { return }
        eulerAngles = SCNVector3(x: eulerAngles.x, y: angle, z: eulerAngles.z)
    }
    
    func enterSearchingMode() {
        // Check to make sure we're in the placement state before transitioning and set it appropriately
        guard readyToPlace, !isAnimating else { return }
        readyToPlace = false
        isAnimating = true
        
        // Square will start spinning and pulsing after entering search mode
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
            self.runAction(self.spinAction, forKey: "spin")
            self.runAction(self.pulseAction, forKey: "pulse")
            self.isAnimating = false
        }
        SCNTransaction.animationDuration = 0.25
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // Change the color of the segments, make the fill disappear and slightly increase the square's size
        for node in childNodes {
            node.geometry?.materials.first?.diffuse.contents = UIColor.yellow
        }
        fill.opacity = 0.0
        scale.x *= 1.15
        scale.y *= 1.15
        scale.z *= 1.15
        
        SCNTransaction.commit()
    }
    
    func enterPlacementMode() {
        guard !readyToPlace, !isAnimating else { return }
        isAnimating = true
        
        // Square will stop spinning and pulsing once it has returned to placement mode
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
            self.removeAction(forKey: "spin")
            self.removeAction(forKey: "pulse")
            self.readyToPlace = true
            self.isAnimating = false
        }
        SCNTransaction.animationDuration = 0.25
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // Change the color of the segments to green, rescale and fade the fill in
        for node in childNodes {
            node.geometry?.materials.first?.diffuse.contents = UIColor.green
        }
        scale.x /= 1.15
        scale.y /= 1.15
        scale.z /= 1.15
        fill.opacity = 0.6
        
        SCNTransaction.commit()
    }
    
    
    /* Private Initializer Functions
        Create the segments comprising the square's outline, add a transparent fill,
        and orient the node to sit on the plane.
    */
    
    private func createSegment(width: CGFloat, height: CGFloat) -> SCNNode {
        let segment = SCNPlane(width: width, height: height)
        segment.materials = [colorMaterial]
        
        return SCNNode(geometry: segment)
    }
    
    private func addHorizontalSegment(dx: Float) {
        let segmentNode = createSegment(width: segmentWidth, height: size)
        segmentNode.position.x += dx
        
        addChildNode(segmentNode)
    }
    
    private func addVerticalSegment(dy: Float) {
        let segmentNode = createSegment(width: size, height: segmentWidth)
        segmentNode.position.y += dy
        
        addChildNode(segmentNode)
    }
    
    private func setup() {
        let dist = Float(size) / 2.0
        addHorizontalSegment(dx: dist)
        addHorizontalSegment(dx: -dist)
        addVerticalSegment(dy: dist)
        addVerticalSegment(dy: -dist)
        addChildNode(fill)
        
        // Rotate the node so the square is flat against the floor
        transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
    }
}
