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
    override func view() -> UIView! {
        
        // Instantiate a new ARView
        let view = ARSCNView()
        view.bounds = UIScreen.main.bounds
        
        // Load a scene from local assests
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Generate a new world tracking config
        let configuration = ARWorldTrackingConfiguration()
        
        // Set the scene
        view.scene = scene
        
        // Run the view's session
        view.session.run(configuration)
        
        return view
    }
}
