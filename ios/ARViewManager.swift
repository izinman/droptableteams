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
        arView.screenCenter = arView.center
        arView.delegate = arView
        arView.scene = SCNScene()
        arView.autoenablesDefaultLighting = true
        
        // Add a tap gesture for object placement and selection
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        arView.addGestureRecognizer(tapGesture)
        arView.addGestureRecognizer(pinchGesture)
        arView.addGestureRecognizer(dragGesture)
        arView.addGestureRecognizer(rotateGesture)
        
        // Initialize the AWRTConfig
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isLightEstimationEnabled = true
        
        // Run the ARView
        arView.session.run(config)
        objectToPlace = "chair"
        
        return arView
    }
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        arView.addObject(name: objectToPlace!)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            arView.scaleObject(scale: gesture.scale)
            gesture.scale = 1.0
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let touchLocation = gesture.location(in: arView)
        arView.selectObject(location: touchLocation)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        arView.dragObject(gesture: gesture)
    }
    
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        arView.rotateObject(gesture: gesture)
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
