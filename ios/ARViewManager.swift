//
//  ARViewManager.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/14/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import MultipeerConnectivity

@objc(ARViewManager)
class ARViewManager : RCTViewManager, ARSessionDelegate {
    
    var arView = ARView()
    var inPlacementMode = false
    var objectToPlace: String?
    
    var mapProvider: MCPeerID?
    var multipeerSession: MultipeerSession = MultipeerSession()
    
    // REPLACE WITH REACT BUTTONS
    var sendMapButtonEnabled: Bool = false
    var sessionInfoLabel: String = ""
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        arView.arViewManager = self
        
        // Set the bounds of the view to be the screen
        arView.bounds = UIScreen.main.bounds
        
        // REASON WHY WE MIGHT WANT ARView TO IMPLEMENT ARSCN_VIEW_DELEGATE, should be self
        arView.delegate = arView
        
        // Initialize the AWRTConfig and the scene
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isLightEstimationEnabled = true
        arView.scene = SCNScene()
        
        // Configure dataHandler
        multipeerSession.receivedDataHandler = receivedData
        
        // Add a tap gesture for object placement and selection
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        // Run the ARView
        arView.session.run(config)
        objectToPlace = "coffee_table"
        
        return arView
    }
    
    // Probably going to be @objc when we have a button
    // @objc func adjustObject(_ node: ARSCNView!, buttonPressed: String)
    func shareSession() {
        print("PEER: Map attempting to be shared")
        arView.session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap
                else { print("Error: \(error!.localizedDescription)"); print("PEER Can't send map"); return }
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                else { fatalError("can't encode map") }
            self.multipeerSession.sendToAllPeers(data)
            print("PEER: Map sent\n")
        }
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let touchLocation = sender.location(in: arView)
        
        if inPlacementMode == true, let name = objectToPlace {
            addObject(location: touchLocation, name: name)
            inPlacementMode = false
        } else {
            arView.selectObject(location: touchLocation)
        }
    }
    
    func addObject(location: CGPoint, name: String) {
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = arView.hitTest(location, types: .existingPlaneUsingExtent)
    
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first, let identifier = hitResult.anchor?.identifier, arView.planes[identifier] != nil {
            
            // Create an object to place
            let node = arView.createNode(name: name, hitResult: hitResult)
        
            // Add the object to the scene
            arView.scene.rootNode.addChildNode(node)
            arView.objects.append(node)
        
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: node, requiringSecureCoding: true)
                else { fatalError("can't encode tuple") }
            multipeerSession.sendToAllPeers(data)
        }
    }
    
    @objc func adjustObject(_ node: ARSCNView!, buttonPressed: String) {
        arView.adjustObject(buttonPressed: buttonPressed)
    }
    
    @objc func setObjectToPlace(_node: ARSCNView!, objectName: String) {
        objectToPlace = objectName
    }
    
    
    //
    // MESSY MULTIPEER SHIT START
    //
    
    func receivedData(_ data: Data, from peer: MCPeerID) {
        do {
            if peer != mapProvider, let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) {
                let configuration = ARWorldTrackingConfiguration()
                configuration.planeDetection = .horizontal
                configuration.initialWorldMap = worldMap
                arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
                
                mapProvider = peer
            }
            else if let node = try NSKeyedUnarchiver.unarchivedObject(ofClass: SCNNode.self, from: data) {
                print("PEER: Node unwrapped")
                arView.scene.rootNode.addChildNode(node)
                arView.objects.append(node)
                print("PEER: ADDED PEER'S NODE")
            }
        } catch {
            print("can't decode data recieved from \(peer)")
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        updateSessionInfoLabel(for: session.currentFrame!, trackingState: camera.trackingState)
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        switch frame.worldMappingStatus {
        case .notAvailable, .limited:
            sendMapButtonEnabled = false
            print("PEERS: ", multipeerSession.connectedPeers.isEmpty)
        case .extending:
            sendMapButtonEnabled = !multipeerSession.connectedPeers.isEmpty
            print("PEERS: ", multipeerSession.connectedPeers.isEmpty)
        case .mapped:
            sendMapButtonEnabled = !multipeerSession.connectedPeers.isEmpty
            print("PEERS: ", multipeerSession.connectedPeers.isEmpty)
        }
        //
        // mappingStatusLabel.text = frame.worldMappingStatus.description
        updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
    }
    
    private func updateSessionInfoLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        // Update the UI to provide feedback on the state of the AR experience.
        let message: String
        
        switch trackingState {
        case .normal where frame.anchors.isEmpty && multipeerSession.connectedPeers.isEmpty:
            // No planes detected; provide instructions for this app's AR interactions.
            message = "Move around to map the environment, or wait to join a shared session."
            
        case .normal where !multipeerSession.connectedPeers.isEmpty && mapProvider == nil:
            let peerNames = multipeerSession.connectedPeers.map({ $0.displayName }).joined(separator: ", ")
            message = "Connected with \(peerNames)."
            
        case .notAvailable:
            message = "Tracking unavailable."
            
        case .limited(.excessiveMotion):
            message = "Tracking limited - Move the device more slowly."
            
        case .limited(.insufficientFeatures):
            message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
            
        case .limited(.initializing) where mapProvider != nil,
             .limited(.relocalizing) where mapProvider != nil:
            message = "Received map from \(mapProvider!.displayName)."
            
        case .limited(.relocalizing):
            message = "Resuming session — move to where you were when the session was interrupted."
            
        case .limited(.initializing):
            message = "Initializing AR session."
            
        default:
            // No feedback needed when tracking is normal and planes are visible.
            // (Nor when in unreachable limited-tracking states.)
            message = ""
            
        }
        
        sessionInfoLabel = message
        //sessionInfoView.isHidden = message.isEmpty
    }
    
    //
    // MESSY MULTIPEER SHIT END
    //
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
