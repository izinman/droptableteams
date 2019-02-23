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
    
    var cameraVector: simd_float3 { return session.currentFrame!.camera.eulerAngles }
    var focusSquare: FocusSquare?
    var onObjectSelect: RCTDirectEventBlock?
    var sessionInfoLabel: UILabel!
    var placeButton: UIButton!
    var confirmButton: UIButton!
    var removeButton: UIButton!

    let ObjScaleMap: [String: SCNVector3] = [
        "chair": SCNVector3(x: 0.015, y: 0.015, z: 0.015),
        "vase": SCNVector3(x: 0.0015, y: 0.0015, z: 0.0015),
        "table_1": SCNVector3(x: 0.01, y: 0.01, z: 0.01),
        "coffee_table": SCNVector3(x: 0.25, y: 0.25, z: 0.25),
        "couch_1": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "couch_2": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "couch_3": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "chair_1": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "chair_2": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "wardrobe": SCNVector3(x: 0.02, y: 0.02, z: 0.02)
        
    ]
    
    // Necessary for React Native to recognize object selection event emitter
    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
        onObjectSelect = val
    }
}
