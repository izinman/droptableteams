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
    
    var ARView: ARSCNView!
    var SceneManager: ARSCNManager!
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        // Instantiate a new ARSCNView
        ARView = ARSCNView()
        ARView.bounds = UIScreen.main.bounds
        
        // Instantiate a SceneManager and get the scene/config
        SceneManager = ARSCNManager()
        ARView.scene = SceneManager.scene!
        ARView.delegate = self
        let config = SceneManager.ARWTConfig!
        
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
    
    @objc func addObject(_ node: ARSCNView!) {
        DispatchQueue.main.async {
            self.SceneManager.addObject(objectName: "ship")
        }
    }
}

