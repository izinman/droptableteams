//
//  ARViewManager.swift
//  FreeRealEstate
//
//

import UIKit
import ARKit
import SceneKit
import MultipeerConnectivity

@objc(ARViewManager)
class ARViewManager : RCTViewManager {
    
    var arView = ARView()
    var arViewModel = ARViewModel()
    
    var mapProvider: MCPeerID?
    var multipeerSession: MultipeerSession = MultipeerSession()
    
    // REPLACE WITH REACT BUTTONS
    var sendMapButtonEnabled: Bool = false
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        // Initialize defaults and member variables for ARView
        arView.bounds = UIScreen.main.bounds
        arView.delegate = self
        arView.scene = SCNScene()
        arView.autoenablesDefaultLighting = true
        arView.antialiasingMode = .multisampling4X
        
        arViewModel.arView = arView
        arViewModel.objectToPlace = "chair_1"
        arViewModel.showAdjustButtons = false
        arViewModel.selectionBoxes = [SCNNode: BoundingBox]()
        
        // Add a tap gesture for object placement and selection
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        // Add a drag gesture for object movement
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        arView.addGestureRecognizer(dragGesture)
        
        // Add a rotate gesture for object rotation
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        arView.addGestureRecognizer(rotateGesture)
        
        // Initialize the AWRTConfig
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isLightEstimationEnabled = true
        
        // Configure dataHandler
        multipeerSession.receivedDataHandler = receivedData
        
        // Run the ARView
        arView.session.run(config)
        arView.session.delegate = self
        setupDirectionalLighting(queue: DispatchQueue.main)
        
        // Multipeer UILabel and UIView
        arView.mappingStatusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        arView.mappingStatusLabel.center = CGPoint(x: 160, y: 285)
        arView.mappingStatusLabel.textAlignment = .center
        arView.mappingStatusLabel.text = "I'm a test label"
        arView.addSubview(arView.mappingStatusLabel)
        
        arView.sessionInfoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 21))
        arView.sessionInfoLabel.center = CGPoint(x: 660, y: 285)
        arView.sessionInfoLabel.textAlignment = .center
        arView.sessionInfoLabel.text = "I'm a test label"
        arView.addSubview(arView.sessionInfoLabel)
        
        return arView
    }
    
    func displayDebugInfo() {
        arView.showsStatistics = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
    }
    
    // Necessary for React Native
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
