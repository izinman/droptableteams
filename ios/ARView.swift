//
//  ARView.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/25/19.
//  Copyright © 2019 Facebook. All rights reserved.
//
import Foundation
import ARKit
import SceneKit

class ARView : ARSCNView, ARSCNViewDelegate {
    
    var objects = [SCNNode]()
    var selectedNode: SCNNode?
    var planeDetected = false
    var objectToPlace: String?
    
    var focusSquare: FocusSquare?
    
    var prevX: Float = 0.0
    var prevZ: Float = 0.0
    
    var onObjectSelect: RCTDirectEventBlock?
    var cameraVector: simd_float3 {
        return session.currentFrame!.camera.eulerAngles
    }
    
    let ObjScaleMap: [String: SCNVector3] = [
        "chair": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "vase": SCNVector3(x: 0.0015, y: 0.0015, z: 0.0015),
        "table_2": SCNVector3(x: 0.01, y: 0.01, z: 0.01),
        "coffee_table": SCNVector3(x: 0.25, y: 0.25, z: 0.25)
    ]
    
    // Necessary for React Native to recognize object selection event emitter
    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
        onObjectSelect = val
    }
}
