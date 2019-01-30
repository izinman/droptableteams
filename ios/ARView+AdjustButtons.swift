//
//  ARView+AdjustButtons.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARView {
    // Necessary for React Native to recognize object selection event emitter
    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
        onObjectSelect = val
    }
    
    func getAdjustedCordinates(x: Float, z: Float) -> (CGFloat, CGFloat) {
        // z2 = cosβz_1 − sinβx_1
        // x2 = sinβz_1 + cosβx_1
        let beta: Float = cameraVector.y;
        let adjustedZ = CGFloat(cos(beta) * z - sin(beta) * x)
        let adjustedX = CGFloat(sin(beta) * z + cos(beta) * x)
        
        return (adjustedX, adjustedZ)
    }
    
    func adjustObject(buttonPressed: String) {
        
        switch (buttonPressed) {
            
        case "rotateRight":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0))
            
        case "rotateLeft":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
            
        case "moveLeft":
            let adjustedCoordinates = getAdjustedCordinates(x: -0.01, z: 0)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveRight":
            let adjustedCoordinates = getAdjustedCordinates(x: 0.01, z: 0)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveForward":
            let adjustedCoordinates = getAdjustedCordinates(x: 0, z: -0.01)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveBackward":
            let adjustedCoordinates = getAdjustedCordinates(x: 0, z: 0.01)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "confirmPlacement":
            selectedNode?.opacity = 1.0
            selectedNode = nil
            
        case "deleteObject":
            if let node = selectedNode, let index = objects.index(of: node) {
                objects.remove(at: index)
                node.removeFromParentNode()
            }
            selectedNode = nil
            
        default:
            return
        }
    }
}
