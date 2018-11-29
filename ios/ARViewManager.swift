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
    
    var ARView = ARSCNView()
    var SceneManager = ARSCNManager()
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        
        // Set the bounds of the view to be the screen
        ARView.bounds = UIScreen.main.bounds
        
        // Get the scene and config from the SceneManager
        ARView.delegate = self
        ARView.scene = SceneManager.getScene()
        let config = SceneManager.getConfig()
        
        // Run the ARView
        ARView.session.run(config)
        
        return ARView
    }
    
    @objc func addObject(_ node: ARSCNView!,  count: NSNumber) {
        print(count);
        DispatchQueue.main.async {
            self.SceneManager.addObject(objectName: "ship")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("Found plane: \(planeAnchor)")
    }
    
    func displayDebugInfo() {
        ARView.showsStatistics = true
        ARView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

