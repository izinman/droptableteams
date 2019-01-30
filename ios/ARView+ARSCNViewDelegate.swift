//
//  ARView+ARSCNViewDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/25/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ARKit
import SceneKit

extension ARView {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard focusSquare == nil else { return }
        
        // Create a new focus square
        let node = FocusSquare()
        
        // Add it to the root of our current scene
        scene.rootNode.addChildNode(node)
        
        // Store the focus square
        focusSquare = node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // If we haven't established a focal node yet do not update
        guard let focusSquare = focusSquare else { return }
        
        // Determine if we hit a plane in the scene
        DispatchQueue.main.async {
            let infPlaneHits = self.hitTest(self.center, types: .existingPlane)

            // Find the position of the first plane we hit
            guard let newPos = infPlaneHits.first?.worldTransform.columns.3 else { return }
            let newPosVec = SCNVector3(x: newPos.x, y: newPos.y, z: newPos.z)

            // Update the position of the node
            let moveAction = SCNAction.move(to: newPosVec, duration: 0.05)
            moveAction.timingMode = .easeInEaseOut
            focusSquare.runAction(moveAction)
            
            let extendPlaneHits = self.hitTest(self.center, types: .existingPlaneUsingExtent)

            if extendPlaneHits.first == nil {
                self.planeDetected = false
                focusSquare.enterSearchingMode()
                let rotateAction = SCNAction.rotateBy(x: 0, y: 0.08, z: 0, duration: 0.5)
                focusSquare.runAction(rotateAction)
                
            } else if !focusSquare.readyToPlace {
                self.planeDetected = true
                focusSquare.enterPlacementMode()
            }
            
        }
    }

}
