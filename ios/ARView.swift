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
    var connectedPeersView: UIView!
    var connectedPeersLabel: UILabel!
    var placeButton: UIButton!
    var confirmButton: UIButton!
    var removeButton: UIButton!
}
