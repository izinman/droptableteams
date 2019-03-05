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

    func addPeersLabel() {
        // Multipeer UILabel and UIView
        arView.connectedPeersView = UIView(frame: CGRect(x: arViewModel.center_x_bound - 95, y: arViewModel.center_y_bound * 0.05, width: 250, height: 35))
        arView.connectedPeersView.backgroundColor = UIColor.gray.withAlphaComponent(0.45)
        arView.connectedPeersView.layer.cornerRadius = 8
        arView.connectedPeersView.clipsToBounds = true
        arView.connectedPeersView.transform = CGAffineTransform(scaleX: 0.01, y: 1)
        arView.connectedPeersView.alpha = 0.0
        arView.addSubview(arView.connectedPeersView)
        
        arView.connectedPeersLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 35))
        arView.connectedPeersLabel.textColor = UIColor.white
        arView.connectedPeersLabel.textAlignment = .center
        arView.connectedPeersLabel.text = "Connected with Artem"
        arView.connectedPeersLabel.alpha = 0.0
        arView.connectedPeersView.addSubview(arView.connectedPeersLabel)
    }
    
    func showPeersLabel() {
        guard let hidden = arViewModel.peerLabelHidden else { return }
        if (hidden) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    self.arView.connectedPeersView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.arView.connectedPeersView.alpha = 1.0
                }, completion: { _ in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.arView.connectedPeersLabel.alpha = 1.0
                    }, completion: { _ in self.arViewModel.peerLabelHidden = false})
                })
            }
        }
    }
    
    func hidePeersLabel() {
        guard let hidden = arViewModel.peerLabelHidden else { return }
        if (!hidden) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
                    self.arView.connectedPeersLabel.alpha = 0.0
                })
                
                UIView.animate(withDuration: 0.2, delay: 0.10, options: .curveEaseIn, animations: {
                    self.arView.connectedPeersView.transform = CGAffineTransform(scaleX: 0.01, y: 1)
                    self.arView.connectedPeersView.alpha = 0.0
                }, completion: { _ in self.arViewModel.peerLabelHidden = true})
            }
        }
    }
    
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
    
    
    func sendUpdate(node: SCNNode, name: UInt8?, x: Float?, y: Float?, z: Float?, rotation: Float?) {
        var hasher = Hasher()
        hasher.combine(node)
        var hashValue = Int64(hasher.finalize())
        if let peerHash = arViewModel.selfHashToPeerHash[hashValue] {
            hashValue = peerHash
        }
        print("PEER: sender hash: \(hashValue)")
        let nodeUpdate = MultipeerUpdate(name: name, nodeHash: hashValue, x: x, y: y, z: z, rotation: rotation)
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
                let name = update.name
                let x = update.x
                let y = update.y
                let z = update.z
                let rotation = update.rotation
                
                if let objNameByte = name {         // name is not nil, receiving new node placement
                    let objName = arViewModel.byteToNameMap[objNameByte]!
                    guard let newNode = createNode(objName: objName, x: x!, y: y!, z: z!, rotation: rotation!) else { return }
                    
                    arView.scene.rootNode.addChildNode(newNode)
                    arViewModel.objects.append(newNode)
                    
                    var hasher = Hasher()
                    hasher.combine(newNode)
                    let selfNodeHash = Int64(hasher.finalize())
                    
                    arViewModel.objectHashTable[peerNodeHash] = newNode
                    arViewModel.selfHashToPeerHash[selfNodeHash] = peerNodeHash
                    
                    let appearAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.2)
                    appearAction.timingMode = .easeInEaseOut
                    newNode.runAction(appearAction)
                } else if let dX = x, let dZ = z {    // Name is nil but coordinates aren't, must be move action
                    
                    var unwrappedNode = arViewModel.objectHashTable[peerNodeHash]
                    if unwrappedNode == nil {
                        // peer created node
                        if let selfNodeHash = arViewModel.selfHashToPeerHash[peerNodeHash] {
                            unwrappedNode = arViewModel.objectHashTable[selfNodeHash]
                            if unwrappedNode == nil { fatalError("Error: Node not in hash table") }
                        }
                    }
                    
                    let moveAction = SCNAction.moveBy(x: CGFloat(dX), y: 0, z: CGFloat(dZ), duration: 0.1)
                    unwrappedNode?.runAction(moveAction)
                } else if let dRotate = rotation {      // Coordinates are nil but rotation isnt, must be rotate action
                    
                    var unwrappedNode = arViewModel.objectHashTable[peerNodeHash]
                    if unwrappedNode == nil {
                        // peer created node
                        if let selfNodeHash = arViewModel.selfHashToPeerHash[peerNodeHash] {
                            unwrappedNode = arViewModel.objectHashTable[selfNodeHash]
                            if unwrappedNode == nil { fatalError("Error: Node not in hash table") }
                        }
                    }
                    
                    let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(dRotate), z: 0, duration: 0.1)
                    unwrappedNode?.runAction(rotateAction)
                } else {
                    // Action is nil, remove the node
                    if
                        let removedNode = arViewModel.objectHashTable[peerNodeHash],
                        let index = arViewModel.objects.index(of: removedNode) {
                        // self created node
                        
                        let fadeAction = SCNAction.fadeOpacity(to: 0.0, duration: 0.15)
                        fadeAction.timingMode = SCNActionTimingMode.easeInEaseOut
                        arViewModel.selectionBoxes[removedNode]?.disappear()
                        removedNode.runAction(fadeAction, completionHandler: {
                            self.arViewModel.objects.remove(at: index)
                            self.arViewModel.selectionBoxes.removeValue(forKey: removedNode)
                            self.arViewModel.objectHashTable.removeValue(forKey: peerNodeHash)
                            removedNode.removeFromParentNode()
                        })
                        
                        if let selectedNode = arViewModel.selectedNode, selectedNode == removedNode {
                            print("PEER: Inside selected Node")
                            arViewModel.selectedNode = nil
                            arView.focusSquare?.appear()
                            hideAdjustmentButtons()
                        }
                    } else if
                        let selfNodeHash = arViewModel.selfHashToPeerHash[peerNodeHash],
                        let removedNode = arViewModel.objectHashTable[selfNodeHash],
                        let index = arViewModel.objects.index(of: removedNode) {
                        // peer craeted node
                        
                        let fadeAction = SCNAction.fadeOpacity(to: 0.0, duration: 0.15)
                        fadeAction.timingMode = SCNActionTimingMode.easeInEaseOut
                        arViewModel.selectionBoxes[removedNode]?.disappear()
                        removedNode.runAction(fadeAction, completionHandler: {
                            self.arViewModel.objects.remove(at: index)
                            self.arViewModel.selectionBoxes.removeValue(forKey: removedNode)
                            self.arViewModel.objectHashTable.removeValue(forKey: selfNodeHash)
                            self.arViewModel.selfHashToPeerHash.removeValue(forKey: peerNodeHash)
                            removedNode.removeFromParentNode()
                        })
                        
                        if let selectedNode = arViewModel.selectedNode, selectedNode == removedNode {
                            print("PEER: Inside selected Node")
                            arViewModel.selectedNode = nil
                            arView.focusSquare?.appear()
                            hideAdjustmentButtons()
                        }
                    }
                }
            }
        } catch {
            print("not a node update")
        }
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
