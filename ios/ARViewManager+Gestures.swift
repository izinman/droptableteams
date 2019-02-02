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
        guard let node = arView.selectedNode else { return }
        // If an object has been selected, scale it by the amount the user pinches or expands
        if gesture.state == .began || gesture.state == .changed {
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
            
            // If an object was already selected, make its selection box disappear and delay the appearance of a new one
            var delayAppear = 0.0
            if let prevSelectedNode = arView.selectedNode {
                arView.selectionBoxes[prevSelectedNode]?.disappear()
                delayAppear = 0.2
                
                // The user has tapped an object to deselect it, thus there is now no selected node and the focusSquare should appear
                if node == prevSelectedNode {
                    arView.selectedNode = nil
                    arView.focusSquare?.appear()
                    return
                }
            }
            
            // Select the node and get a reference to its selection box
            arView.selectedNode = node
            var selectionBox = arView.selectionBoxes[node]
            
            // If the node had not yet been selected, initialize a new selection box and store the reference
            if selectionBox == nil {
                selectionBox = BoundingBox(node: node)
                arView.selectionBoxes[node] = selectionBox
            }
            
            // Make the focusSquare disappear and render the selection box
            arView.focusSquare?.disappear()
            selectionBox?.runAction(SCNAction.wait(duration: delayAppear), completionHandler: { selectionBox?.appear() })
            
            // Tell React to display adjustment button menu
            arView.onObjectSelect!([:])
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let node = arView.selectedNode else { return }
        
        let location = gesture.location(in: arView)
        guard let result = arView.hitTest(location, types: .existingPlane).first else { return }
        
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
