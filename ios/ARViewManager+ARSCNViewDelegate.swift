//
//  ARViewManager+ARSCNViewDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARViewManager: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard arView.focusSquare == nil else { return }
        
        // Create a new focus square
        let node = FocusSquare()
        
        // Add it to the root of our current scene
        arView.scene.rootNode.addChildNode(node)
        
        // Store the focus square
        arView.focusSquare = node
        showPlaceButton()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                self.adjustObjectOntoPlane(node: node, anchor: planeAnchor)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // If we haven't established a focusSquare yet do not update
        guard let focusSquare = arView.focusSquare else { return }
        
        DispatchQueue.main.async {
            let arView = self.arView
            // Run a hit test to find the new location for the focusSquare
            guard let newPos = arView.hitTest(arView.center, types: .existingPlane).first?.worldTransform.columns.3 else { return }
            let newPosVec = SCNVector3(x: newPos.x, y: newPos.y, z: newPos.z)
            
            // Determine if the resulting position is a valid plane for placement
            let didFindPlaneUsingExtent = (arView.hitTest(arView.center, types: .existingPlaneUsingExtent).first != nil)
            
            // Update the location, orientation, and state of the square
            focusSquare.update(location: newPosVec, foundPlane: didFindPlaneUsingExtent, cameraAngle: arView.cameraVector.y)
        }
        
        if let lightEstimate = arView.session.currentFrame?.lightEstimate {
            updateDirectionalLighting(intensity: lightEstimate.ambientIntensity * 3, queue: DispatchQueue.main)
        }
    }
    
    func adjustObjectOntoPlane(node: SCNNode?, anchor: ARPlaneAnchor) {
        guard let object = node, let planeAnchorNode = arView.node(for: anchor) else {
            return
        }
        
        // Get the object's position in the plane's coordinate system.
        let objectPos = planeAnchorNode.convertPosition(object.position, from: object.parent)
        
        if objectPos.y == 0 {
            return; // The object is already on the plane - nothing to do here.
        }
        
        // Add 10% tolerance to the corners of the plane.
        let tolerance: Float = 0.1
        
        let minX: Float = anchor.center.x - anchor.extent.x / 2 - anchor.extent.x * tolerance
        let maxX: Float = anchor.center.x + anchor.extent.x / 2 + anchor.extent.x * tolerance
        let minZ: Float = anchor.center.z - anchor.extent.z / 2 - anchor.extent.z * tolerance
        let maxZ: Float = anchor.center.z + anchor.extent.z / 2 + anchor.extent.z * tolerance
        
        if objectPos.x < minX || objectPos.x > maxX || objectPos.z < minZ || objectPos.z > maxZ {
            return
        }
        
        // Drop the object onto the plane if it is near it.
        let verticalAllowance: Float = 0.03
        if objectPos.y > -verticalAllowance && objectPos.y < verticalAllowance {
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            object.position.y = anchor.transform.columns.3.y
            SCNTransaction.commit()
        }
    }
}
