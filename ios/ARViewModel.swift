//
//  ARViewModel.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 2/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class ARViewModel {
    var arView: ARView?
    
    
    let viewBounds: CGRect = UIScreen.main.bounds
    var center_x_bound: Double { return floor(Double((viewBounds.maxX + viewBounds.minX)/2)) - 30 }
    var center_y_bound: Double { return floor(Double((viewBounds.maxY + viewBounds.minY) * 0.85)) }
    var confirm_x_bound: Double { return center_x_bound - 60.0 }
    var remove_x_bound: Double { return center_x_bound + 60.0 }
    
    var objects = [SCNNode]()
    var objectHashTable = [Int64:SCNNode]()
    var selfHashToPeerHash = [Int64:Int64]()
    var objectToPlace: String?
    
    var sceneLight: SCNNode?
    let objectLightingMask:Int = 42
    var lightingRootNode: SCNNode? {
        return arView?.scene.rootNode.childNode(withName: "lightingRootNode", recursively: true)
    }
    
    var selectedNode: SCNNode?
    var selectionBoxes: [SCNNode: BoundingBox]!
    var prevX: Float = 0.0  // Used for tracking the drag gesture's displacement
    var prevZ: Float = 0.0
    
    var showAdjustButtons: Bool?
    
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
}
