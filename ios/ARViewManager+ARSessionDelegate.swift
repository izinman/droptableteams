//
//  ARViewManager+ARSessionDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ARKit

extension ARViewManager {
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {}
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {}
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {}
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard arViewModel.canSendMap else { return }
        if frame.worldMappingStatus == .mapped, mapProvider == nil, !multipeerSession.connectedPeers.isEmpty {
            mapProvider = self.multipeerSession.myPeerID
            arView.session.getCurrentWorldMap { worldMap, error in
                guard let map = worldMap else {
                        print("Error: \(error!.localizedDescription)"); print("PEER: Can't send map")
                        self.mapProvider = nil
                        return
                }
                guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                    else { fatalError("PEER: can't encode map") }
                print("PEER: Map sent")
                self.multipeerSession.sendToAllPeers(data)
                var ctr = 0
                
                for node in self.arViewModel.objects {
                    print("PEER: For loop: node: \(node), iter: \(ctr)")
                    let nodeName = self.arViewModel.objNameMap[node]
                    let x = node.worldPosition.x
                    let y = node.worldPosition.y
                    let z = node.worldPosition.z
                    let rotation = node.eulerAngles.y
                    
                    self.sendUpdate(node: node, name: nodeName, x: x, y: y, z: z, rotation: rotation)
                    ctr += 1
                }
            }
        }
        updateConnectedPeersLabel(for: frame, trackingState: frame.camera.trackingState)
    }
    
    private func updateConnectedPeersLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        // Update the UI to provide feedback on the state of the AR experience.
        let message: String
        if !multipeerSession.connectedPeers.isEmpty && mapProvider != nil {
            let peerNames = multipeerSession.connectedPeers.map({ $0.displayName.components(separatedBy: "'s ").first ?? $0.displayName }).joined(separator: ", ")
            message = "Connected with \(peerNames)"
        } else {
            message = ""
        }
        
        arView.connectedPeersLabel.text = message
        if (!message.isEmpty) {
            showPeersLabel()
        } else {
            hidePeersLabel()
        }
    }
}
