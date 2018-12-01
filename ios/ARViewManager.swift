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
class ARViewManager : RCTViewManager, ARSCNViewDelegate {
    
    var arView = ARSCNView()
    var sceneManager = ARSCNManager()
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        
        // Set the bounds of the view to be the screen
        arView.bounds = UIScreen.main.bounds
        
        // Get the scene and config from the SceneManager
        arView.delegate = self
        arView.scene = sceneManager.getScene()
        let config = sceneManager.getConfig()
        
        // Run the ARView
        arView.session.run(config)
        
        return arView
    }
    
    @objc func addObject(_ node: ARSCNView!,  count: NSNumber) {
        print(count);
        DispatchQueue.main.async {
            self.sceneManager.addObject(objectName: "ship")
        }
    }
    
    private func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("Found plane: \(planeAnchor)")
    }
    
    func displayDebugInfo() {
        arView.showsStatistics = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

