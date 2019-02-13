//
//  MultipeerUpdate.swift
//  FreeRealEstate
//
//  Created by Cole Margerum on 2/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import SceneKit

struct MultipeerUpdate: Codable {
    
    var node: SCNNode?
    var nodeHash: Int
    var action: SCNAction?
    
    init(node: SCNNode?, nodeHash: Int, action: SCNAction?) {
        self.node = node
        self.nodeHash = nodeHash
        self.action = action
    }
    enum CodingKeys: String, CodingKey {
        case node
        case nodeHash
        case action
    }
}

extension MultipeerUpdate {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        node = try values.decode(SCNNode.self, forKey: .node)
        nodeHash = try values.decode(Int.self, forKey: .nodeHash)
        action = try values.decode(SCNAction.self, forKey: .action)
    }
}

extension MultipeerUpdate {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(node, forKey: .node)
        try container.encode(nodeHash, forKey: .nodeHash)
        try container.encode(action, forKey: .action)
    }
}



//protocol DataConvertible {
//    init?(data: Data)
//    var data: Data { get }
//}
//
//extension DataConvertible {
//    init?(data: Data) {
//        guard data.count == MemoryLayout<Self>.stride else { return nil }
//        self = data.withUnsafeBytes { $0.pointee }
//    }
//    var data: Data {
//        var value = self
//        return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
//    }
//}
