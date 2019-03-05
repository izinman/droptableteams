//
//  MultipeerUpdate.swift
//  FreeRealEstate
//
//  Created by Cole Margerum on 2/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import SceneKit

class MultipeerUpdate: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool = true
    // name: UInt8?, x: Float?, y: Float?, z: Float?, rotation: CGFloat?
    var nodeHash: Int64
    var name: UInt8?
    var x: Float?
    var y: Float?
    var z: Float?
    var rotation: Float?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nodeHash, forKey: "h")
        aCoder.encode(name, forKey: "n")
        aCoder.encode(x, forKey: "x")
        aCoder.encode(y, forKey: "y")
        aCoder.encode(z, forKey: "z")
        aCoder.encode(rotation, forKey: "r")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nodeHash = aDecoder.decodeInt64(forKey: "h")
        let name = aDecoder.decodeObject(forKey: "n") as? UInt8
        let x = aDecoder.decodeObject(forKey: "x") as? Float
        let y = aDecoder.decodeObject(forKey: "y") as? Float
        let z = aDecoder.decodeObject(forKey: "z") as? Float
        let rotation = aDecoder.decodeObject(forKey: "r") as? Float
        
        self.init(
            name: name,
            nodeHash: nodeHash,
            x: x,
            y: y,
            z: z,
            rotation: rotation
        )
    }
    
    init(name: UInt8?, nodeHash: Int64, x: Float?, y: Float?, z: Float?, rotation: Float?) {
        self.name = name
        self.nodeHash = nodeHash
        self.x = x
        self.y = y
        self.z = z
        self.rotation = rotation
    }
}
