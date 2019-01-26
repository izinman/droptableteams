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
        arView.addGestureRecognizer(tapGesture)
        
        // Run the ARView
        arView.session.run(config)
        
        return arView
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let touchLocation = sender.location(in: arView)
        
        if inPlacementMode == true {
            arView.addObject(location: touchLocation)
            inPlacementMode = false
        } else {
            arView.selectObject(location: touchLocation)
        }
    }
    
    @objc func adjustObject(_ node: ARSCNView!, buttonPressed: String) {
        arView.adjustObject(buttonPressed: buttonPressed)
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
