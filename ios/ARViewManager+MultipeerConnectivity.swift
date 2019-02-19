//
//  ARViewManager+MultipeerConnectivity.swift
//  FreeRealEstate
//
//  Created by Cole Margerum on 2/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//
import ARKit
import SceneKit
import MultipeerConnectivity

extension ARViewManager: ARSessionDelegate {

    @objc func sendMap(_ node: ARSCNView!) {
        print("PEER: Map attempting to be shared")
        arView.session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap
                else { print("Error: \(error!.localizedDescription)"); print("PEER Can't send map"); return }
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                else { fatalError("can't encode map") }
            self.multipeerSession.sendToAllPeers(data)
            self.mapProvider = self.multipeerSession.myPeerID
        }
        print("PEER: Map sent\n")
    }
    
    func sendNodeUpdate(forNode node: SCNNode, withAction action: SCNAction?) {
        var hasher = Hasher()
        hasher.combine(node)
        var hashValue = Int64(hasher.finalize())
        if let peerHash = arViewModel.selfHashToPeerHash[hashValue] {
            hashValue = peerHash
        }
        print("PEER: sender hash: \(hashValue)")
        let sendNode = arViewModel.objects.contains(node) ? nil : node
        let nodeUpdate = MultipeerUpdate(node: sendNode, nodeHash: hashValue, action: action)
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: nodeUpdate, requiringSecureCoding: false)
        else { fatalError("can't encode node update") }
        
        multipeerSession.sendToAllPeers(data)
    }

    func receivedData(_ data: Data, from peer: MCPeerID) {
        //let update = MultipeerUpdate(data: data)
        print("PEER: INSIDE RECEIVED DATA")
        do {
            if let update = try NSKeyedUnarchiver.unarchivedObject(ofClass: MultipeerUpdate.self, from: data) {
                print("PEER: INSIDE IF!!!")
                let peerNodeHash = update.nodeHash
                print("PERR: peerNodeHash \(peerNodeHash)")
                if let action = update.action  {
                    print("PEER: DATA RECEIVED!!!")
                    let actionNode: SCNNode
                    if let node = update.node {
                        arView.scene.rootNode.addChildNode(node)
                        arViewModel.objects.append(node)
                        
                        var hasher = Hasher()
                        hasher.combine(node)
                        let selfNodeHash = Int64(hasher.finalize())
                        
                        arViewModel.objectHashTable[peerNodeHash] = node
                        arViewModel.selfHashToPeerHash[selfNodeHash] = peerNodeHash
                        
                        actionNode = node
                    } else {
                        // Handle Rotate or Pan
                        if let unwrappedNode = arViewModel.objectHashTable[peerNodeHash]  {
                            // self created node
                            actionNode = unwrappedNode
                        } else {
                            // peer created node
                            guard let selfNodeHash = arViewModel.selfHashToPeerHash[peerNodeHash], let unwrappedNode = arViewModel.objectHashTable[selfNodeHash] else {
                                fatalError("PEER: Node not in hash table")
                            }
                            actionNode = unwrappedNode
                        }
                    }
                    actionNode.runAction(action)
                } else {
                    // Action is nil, remove the node
                    if
                        let removedNode = arViewModel.objectHashTable[peerNodeHash],
                        let index = arViewModel.objects.index(of: removedNode) {
                        // self created node
                        
                        arViewModel.objects.remove(at: index)
                        arViewModel.objectHashTable.removeValue(forKey: peerNodeHash)
                        removedNode.removeFromParentNode()
                    } else if
                        let selfNodeHash = arViewModel.selfHashToPeerHash[peerNodeHash],
                        let removedNode = arViewModel.objectHashTable[selfNodeHash],
                        let index = arViewModel.objects.index(of: removedNode) {
                        // peer craeted node
                        
                        arViewModel.objects.remove(at: index)
                        arViewModel.objectHashTable.removeValue(forKey: peerNodeHash)
                        arViewModel.selfHashToPeerHash.removeValue(forKey: peerNodeHash)
                        removedNode.removeFromParentNode()
                    }
                }
            }
        } catch {
            if mapProvider != nil {
                print("PEER: DATA NOT RECEIVED")
            }
        }
        
        // Putting this after update code bc 170 taught me that try catch is costly, and the above will fail if it's not
        // a map (hopefully)
        do {
            if mapProvider == nil, let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) {
                
                let configuration = ARWorldTrackingConfiguration()
                configuration.planeDetection = .horizontal
                configuration.initialWorldMap = worldMap
                arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
                mapProvider = peer
                
                print("PEER: MAP RECEIVED")
                
                return
            }
        } catch {
            print("can't decode data recieved from \(peer)")
        }
    }
}

extension ARFrame.WorldMappingStatus {
    public var description: String {
        switch self {
        case .notAvailable:
            return "Not Available"
        case .limited:
            return "Limited"
        case .extending:
            return "Extending"
        case .mapped:
            return "Mapped"
        }
    }
}
