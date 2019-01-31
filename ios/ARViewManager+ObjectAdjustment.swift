//
//  ARViewManager+ObjectAdjustment.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARViewManager {
    
    func getAdjustedCordinates(x: Float, z: Float) -> (CGFloat, CGFloat) {
        // z2 = cosβz_1 − sinβx_1
        // x2 = sinβz_1 + cosβx_1
        let beta: Float = arView.cameraVector.y;
        let adjustedZ = CGFloat(cos(beta) * z - sin(beta) * x)
        let adjustedX = CGFloat(sin(beta) * z + cos(beta) * x)
        
        return (adjustedX, adjustedZ)
    }
    
    @objc func adjustObject(_node: ARSCNView!, buttonPressed: String) {
        guard let node = arView.selectedNode else { return }
        
        switch (buttonPressed) {
            
        case "rotateRight":
            node.runAction(SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0))
            
        case "rotateLeft":
            node.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
            
        case "moveLeft":
            let adjustedCoordinates = getAdjustedCordinates(x: -0.01, z: 0)
            node.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveRight":
            let adjustedCoordinates = getAdjustedCordinates(x: 0.01, z: 0)
            node.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveForward":
            let adjustedCoordinates = getAdjustedCordinates(x: 0, z: -0.01)
            node.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "moveBackward":
            let adjustedCoordinates = getAdjustedCordinates(x: 0, z: 0.01)
            node.runAction(SCNAction.moveBy(x: adjustedCoordinates.0, y: 0, z: adjustedCoordinates.1, duration: 0))
            
        case "confirmPlacement":
            node.opacity = 1.0
            arView.selectedNode = nil
            
        case "deleteObject":
            if let index = arView.objects.index(of: node) {
                arView.objects.remove(at: index)
                node.removeFromParentNode()
            }
            arView.selectedNode = nil
            
        default:
            return
        }
    }
}
