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

@objc(ARViewManager)
class ARViewManager : RCTViewManager {
    
    var arView = ARView()
    var inPlacementMode = false
    var objectToPlace: String?
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        // Set the bounds of the view to be the screen
        arView.bounds = UIScreen.main.bounds
        
        arView.delegate = arView
        
        // Initialize the AWRTConfig and the scene
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isLightEstimationEnabled = true
        arView.scene = SCNScene()
        
        // Add a tap gesture for object placement and selection
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        arView.addGestureRecognizer(tapGesture)
        arView.addGestureRecognizer(pinchGesture)
        
        // Run the ARView
        arView.session.run(config)
        objectToPlace = "coffee_table"
        
        return arView
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            arView.scaleObject(scale: sender.scale)
            sender.scale = 1.0
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let touchLocation = sender.location(in: arView)
        
        if inPlacementMode == true, let name = objectToPlace {
            arView.addObject(location: touchLocation, name: name)
            inPlacementMode = false
        } else {
            arView.selectObject(location: touchLocation)
        }
    }
    
    @objc func adjustObject(_ node: ARSCNView!, buttonPressed: String) {
        arView.adjustObject(buttonPressed: buttonPressed)
    }
    
    @objc func setObjectToPlace(_node: ARSCNView!, objectName: String) {
        objectToPlace = objectName
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
