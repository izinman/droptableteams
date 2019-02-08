//
//  MultipeerUpdate.swift
//  FreeRealEstate
//
//  Created by Cole Margerum on 2/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import SceneKit

class MultipeerUpdate: DataConvertible {
    var node: SCNNode?
    var nodeHash: Int
    var action: SCNAction?
    
    init(node: SCNNode?, nodeHash: Int, action: SCNAction?) {
        self.node = node
        self.nodeHash = nodeHash
        self.action = action
    }
}

protocol DataConvertible {
    init?(data: Data)
    var data: Data { get }
}

extension DataConvertible {
    init?(data: Data) {
        guard data.count == MemoryLayout<Self>.stride else { return nil }
        self = data.withUnsafeBytes { $0.pointee }
    }
    var data: Data {
        var value = self
        return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
}
