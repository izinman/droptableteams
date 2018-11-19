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
    
    var ARView: ARSCNView!
    var ARSCNManager: SceneManager!
    
    @objc func addObject(_ node: ARSCNView!) {
        DispatchQueue.main.async {
            self.ARSCNManager.addObject(objectName: "ship")
        }
    }
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView! {
        
        // Instantiate a new ARSCNView
        ARView = ARSCNView()
        ARView.bounds = UIScreen.main.bounds
        
        // Instantiate a SceneManager and get the scene/config
        ARSCNManager = SceneManager()
        ARView.scene = ARSCNManager.scene!
        let config = ARSCNManager.ARWTConfig!
        
        // Run the ARView
        ARView.session.run(config)
        
        return ARView
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

