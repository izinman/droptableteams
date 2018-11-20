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
    var ARSCNManager: SceneManager!
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        // Instantiate a new ARSCNView
        ARView = ARSCNView()
        ARView.bounds = UIScreen.main.bounds
        
        // Instantiate a SceneManager and get the scene/config
        ARSCNManager = SceneManager()
        ARView.scene = ARSCNManager.scene!
        ARView.delegate = self
        let config = ARSCNManager.ARWTConfig!
        
        // Run the ARView
        ARView.session.run(config)
        
        return ARView
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("Found plane: \(planeAnchor)")
    }
    
    func displayDegubInfo() {
        ARView?.showsStatistics = true
        ARView?.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func addObject(_ node: ARSCNView!) {
        DispatchQueue.main.async {
            self.ARSCNManager.addObject(objectName: "ship")
        }
    }
}

