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
    
    var nodeHash: Int64
    var action: SCNAction?
    var node: SCNNode?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nodeHash, forKey: "nodeHash")
        
        if action != nil {
            do {
                let actionEncoded = try NSKeyedArchiver.archivedData(withRootObject: action!, requiringSecureCoding: false)
                aCoder.encode(actionEncoded, forKey: "action")
                print("PEER: encoded action")
            } catch {}
        }
        
        if node != nil {
            do {
                let nodeEncoded = try NSKeyedArchiver.archivedData(withRootObject: node!, requiringSecureCoding: false)
                aCoder.encode(nodeEncoded, forKey: "node")
                print("PEER: encoded node")
            } catch {}
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nodeHash = aDecoder.decodeInt64(forKey: "nodeHash")
        
        let actionDecoded: SCNAction?
        if let actionData = aDecoder.decodeObject(forKey: "action") as? Data {
            do {
                actionDecoded = try NSKeyedUnarchiver.unarchivedObject(ofClass: SCNAction.self, from: actionData)
            } catch {
                actionDecoded = nil
            }
        } else {
            actionDecoded = nil
        }
        
        let nodeDecoded: SCNNode?
        if let nodeData = aDecoder.decodeObject(forKey: "node") as? Data {
            do {
                nodeDecoded = try NSKeyedUnarchiver.unarchivedObject(ofClass: SCNNode.self, from: nodeData)
            } catch {
                nodeDecoded = nil
            }
        } else {
            nodeDecoded = nil
        }
        
        self.init(
            node: nodeDecoded,
            nodeHash: nodeHash,
            action: actionDecoded
        )
    }
    
    init(node: SCNNode?, nodeHash: Int64, action: SCNAction?) {
        self.node = node
        self.nodeHash = nodeHash
        self.action = action
    }
}
