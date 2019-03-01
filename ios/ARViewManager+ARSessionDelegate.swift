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
        if frame.worldMappingStatus == .mapped, mapProvider == nil, !multipeerSession.connectedPeers.isEmpty {
            arView.session.getCurrentWorldMap { worldMap, error in
                guard let map = worldMap
                    else { print("Error: \(error!.localizedDescription)"); print("PEER: Can't send map"); return }
                guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                    else { fatalError("PEER: can't encode map") }
                print("PEER: Map sent")
                self.multipeerSession.sendToAllPeers(data)
                self.mapProvider = self.multipeerSession.myPeerID
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
