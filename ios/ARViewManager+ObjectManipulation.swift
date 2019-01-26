//
//  ARViewManager+ObjectManipulation.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ARKit
import SceneKit

extension ARSCNView {
    @objc var onObjectSelect: RCTDirectEventBlock?
    
    @objc func setSelectedObject() {
        if onObjectSelect != nil {
            onObjectSelect!([:])
        }
    }
}

extension ARViewManager {
    
    func addObject(location: CGPoint) {
        
    }
    
    func selectObject(location: CGPoint) {
        
    }
    
//    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
//        onObjectSelect = val
//    }

  @objc func adjustObject(_ node: ARSCNView!, buttonPressed: String) {
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
            selectedNode?.opacity = 1.0
            selectedNode = nil
        default:
            return
        }
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
}
