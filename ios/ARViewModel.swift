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

let CHAIR_1: UInt8 = 0
let CHAIR_2: UInt8 = 1
let COUCH_1: UInt8 = 2
let COUCH_2: UInt8 = 3
let COUCH_3: UInt8 = 4
let COFFEE_TABLE: UInt8 = 5
let TABLE_1: UInt8 = 6
let WARDROBE: UInt8 = 7
let VASE: UInt8 = 8

class ARViewModel {
    var arView: ARView?
    
    let viewBounds: CGRect = UIScreen.main.bounds
    var center_x_bound: Double { return floor(Double((viewBounds.maxX + viewBounds.minX)/2)) - 30 }
    var center_y_bound: Double { return floor(Double((viewBounds.maxY + viewBounds.minY) * 0.85)) }
    var confirm_x_bound: Double { return center_x_bound - 60.0 }
    var remove_x_bound: Double { return center_x_bound + 60.0 }
    var peerLabelHidden: Bool?
    
    var objects = [SCNNode]()
    var objNameMap = [SCNNode: UInt8]()
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
    
    let ObjScaleMap: [String: SCNVector3] = [
        "chair": SCNVector3(x: 0.015, y: 0.015, z: 0.015),
        "vase": SCNVector3(x: 0.0015, y: 0.0015, z: 0.0015),
        "table_1": SCNVector3(x: 0.005, y: 0.005, z: 0.005),
        "coffee_table": SCNVector3(x: 0.16, y: 0.16, z: 0.16),
        "couch_1": SCNVector3(x: 0.021, y: 0.021, z: 0.021),
        "couch_2": SCNVector3(x: 0.0009, y: 0.0009, z: 0.0009),
        "couch_3": SCNVector3(x: 0.00085, y: 0.00085, z: 0.00085),
        "chair_1": SCNVector3(x: 0.017, y: 0.017, z: 0.017),
        "chair_2": SCNVector3(x: 0.0036, y: 0.0036, z: 0.0036),
        "wardrobe": SCNVector3(x: 0.0007, y: 0.0007, z: 0.0007)
    ]
    
    let byteToNameMap: [UInt8 : String] = [
        CHAIR_1: "chair_1",
        CHAIR_2: "chair_2",
        COUCH_1: "couch_1",
        COUCH_2: "couch_2",
        COUCH_3: "couch_3",
        COFFEE_TABLE: "coffee_table",
        TABLE_1: "table_1",
        WARDROBE: "wardrobe",
        VASE: "vase",
    ]
    
    let nameToByteMap: [String : UInt8] = [
        "chair_1": CHAIR_1,
        "chair_2": CHAIR_2,
        "couch_1": COUCH_1,
        "couch_2": COUCH_2,
        "couch_3": COUCH_3,
        "coffee_table": COFFEE_TABLE,
        "table_1": TABLE_1,
        "wardrobe": WARDROBE,
        "vase": VASE,
    ]
}
