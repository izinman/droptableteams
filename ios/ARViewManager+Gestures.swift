//
//  ARViewManager+Gestures.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARViewManager {
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        // If an object has been selected, scale it by the amount the user pinches or expands
        if gesture.state == .began || gesture.state == .changed, let node = arView.selectedNode {
            let scaleAction = SCNAction.scale(by: gesture.scale, duration: 0.1)
            node.runAction(scaleAction)
            gesture.scale = 1.0 // Necessary to prevent exponential scaling
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let location = gesture.location(in: arView)
        
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = arView.hitTest(location, options: nil)
        
        // Check that the node is not null and select it
        if let node = nodeHits.first?.node, arView.objects.contains(node) {
            // If we had previously selected an object, unhighlight it before selecting a new one
            if let prevSelectedNode = arView.selectedNode {
                prevSelectedNode.removeAction(forKey: "pulse")
                prevSelectedNode.runAction(SCNAction.fadeOpacity(to: 1.0, duration: 0.75))
                
                if node == prevSelectedNode {
                    arView.selectedNode = nil
                    return
                }
            }
            
            // Select the node and mark it visually by reducing the opacity
            arView.selectedNode = node
            currentBoundingBox = BoundingBox(node: node)
            
            let fadeOutAction = SCNAction.fadeOpacity(to: 0.6, duration: 1.0)
            let fadeInAction = SCNAction.fadeOpacity(to: 1.0, duration: 1.0)
            fadeInAction.timingMode = .easeInEaseOut
            
            let pulseAction = SCNAction.repeatForever(SCNAction.sequence([fadeOutAction, fadeInAction]))
            
            node.runAction(pulseAction, forKey: "pulse")
            
            // Tell React to display adjustment button menu
            arView.onObjectSelect!([:])
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: arView)
        guard let node = arView.selectedNode, let result = arView.hitTest(location, types: .existingPlane).first else { return }
        
        let newCoordX = result.worldTransform.columns.3.x
        let newCoordZ = result.worldTransform.columns.3.z
        
        
        if gesture.state == .began {
            arView.prevX = newCoordX
            arView.prevZ = newCoordZ
        }
        
        if gesture.state == .changed {
            
            let distance = getDistance(from: node, to: result)
            let moveAction = SCNAction.moveBy(x: CGFloat(newCoordX - arView.prevX), y: 0, z: CGFloat(newCoordZ - arView.prevZ), duration: 0.1)
            node.runAction(moveAction)
            
            arView.prevX = newCoordX
            arView.prevZ = newCoordZ
            
            gesture.setTranslation(CGPoint.zero, in: arView)
        }
        
        if gesture.state == .ended {
            arView.prevX = 0.0
            arView.prevZ = 0.0
        }
    }
    
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let node = arView.selectedNode else { return }
        
        var originalRotation = node.eulerAngles
        if gesture.state == .changed {
            originalRotation.y -= Float(gesture.rotation)
            node.eulerAngles = originalRotation
            gesture.rotation = 0.3 * gesture.rotation
        }
    }
    
    func getDistance(from: SCNNode, to: ARHitTestResult) -> Float {
        let tmpNode = SCNNode()
        let hitPosition = SCNVector3(to.worldTransform.columns.3.x, to.worldTransform.columns.3.y, to.worldTransform.columns.3.z)
        tmpNode.position = hitPosition
        let nodePosition = from.convertPosition(from.position, to: tmpNode)
       
        let dx = hitPosition.x - nodePosition.x
        let dz = hitPosition.z - nodePosition.z
        
        return sqrtf(dx * dx + dz * dz)
    }
}
