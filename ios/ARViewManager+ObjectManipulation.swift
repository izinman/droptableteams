//
//  ARViewManager+ObjectManipulation.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ARKit
import SceneKit

extension ARViewManager {
    
    func addObject(location: CGPoint) {
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = arView.hitTest(location, types: .existingPlaneUsingExtent)
        
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first, let identifier = hitResult.anchor?.identifier, planes[identifier] != nil {
            // Create an object to place
            let ship = shipNode.clone()
            
            // Adjust the orientation and placement so it sits on the plane
            let rotation = simd_float4x4(SCNMatrix4MakeRotation(arView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
            let hitTransform = simd_mul(hitResult.worldTransform, rotation)
            ship.transform = SCNMatrix4(hitTransform)
            ship.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            
            // Add the object to the scene
            arView.scene.rootNode.addChildNode(ship)
            objects.append(ship)
        }
        
        inPlacementMode = false
    }
    
    func selectObject(location: CGPoint) {
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = arView.hitTest(location, options: nil)
        
        // Check that the node is not null and select it
        if let node = nodeHits.first?.node.parent as? SCNNode, objects.contains(node) {
            selectedNode = node
        }
    }
    
    @objc func adjustNode(buttonPressed: String) {
        switch (buttonPressed) {
        case "rotateRight":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0))
        case "rotateLeft":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
        case "moveLeft":
            selectedNode?.runAction(SCNAction.moveBy(x: -0.01, y: 0, z: 0, duration: 0))
        case "moveRight":
            selectedNode?.runAction(SCNAction.moveBy(x: 0.01, y: 0, z: 0, duration: 0))
        case "moveForward":
            selectedNode?.runAction(SCNAction.moveBy(x: 0, y: 0, z: 0.01, duration: 0))
        case "moveBackward":
            selectedNode?.runAction(SCNAction.moveBy(x: 0, y: 0, z: -0.01, duration: 0))
        case "confirmPlacement":
            selectedNode = nil
        default:
            return
        }
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
}
