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
    var mappingStatusLabel: UILabel!
    var sessionInfoLabel: UILabel!
    
    // Necessary for React Native to recognize object selection event emitter
    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
        onObjectSelect = val
    }
}
