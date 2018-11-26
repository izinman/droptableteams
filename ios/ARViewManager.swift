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
    
    var ARView = ARSCNView()
    var ARSCNManager = SceneManager()
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView! {
        
        // Set the view's bounds to be the screen
        ARView.bounds = UIScreen.main.bounds
        
        // Get initial scene and world tracking config from the SceneManager
        ARView.scene = ARSCNManager.scene
        guard let config = ARSCNManager.ARWTConfig else { fatalError("ARWTConfig not found") }
        
        // Run the ARView
        ARView.session.run(config)
        
        return ARView
    }
    
    @objc func addObject(_ node: ARSCNView!,  count: NSNumber) {
        print(count);
        DispatchQueue.main.async {
            self.ARSCNManager.addObject(objectName: "ship")
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

