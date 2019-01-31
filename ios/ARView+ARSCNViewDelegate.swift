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
        // If we haven't established a focusSquare yet do not update
        guard let focusSquare = focusSquare else { return }
        
        DispatchQueue.main.async {
            // Run a hit test to find the new location for the focusSquare
            guard let newPos = self.hitTest(self.center, types: .existingPlane) .first?.worldTransform.columns.3 else { return }
            let newPosVec = SCNVector3(x: newPos.x, y: newPos.y, z: newPos.z)
            
            // Determine if the resulting position is a valid plane for placement
            let didFindPlaneUsingExtent = (self.hitTest(self.center, types: .existingPlaneUsingExtent).first != nil)
            
            // Update the location, orientation, and state of the square
            focusSquare.updateSquare(toLocation: newPosVec, foundPlane: didFindPlaneUsingExtent, cameraAngle: self.cameraVector.y)
            
            self.planeDetected = focusSquare.readyToPlace
        }
    }

}
