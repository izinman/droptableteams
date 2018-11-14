//
//  SceneManager.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/14/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import ARKit
import SceneKit

class SceneManager : NSObject {
    
    var scene: SCNScene!
    var ARWTConfig: ARWorldTrackingConfiguration?
    
    override init() {
        super.init()
        setARWTConfig(config: nil)
        setScene()
    }
    
    func setARWTConfig(config: ARWorldTrackingConfiguration?) {
        // Check if we are loading an existing config -- if not, create a new one
        if (config == nil) {
            ARWTConfig = ARWorldTrackingConfiguration()
        } else {
            ARWTConfig = config
        }
    }
    
    func setScene() {
        // TODO: Figure out how to load a scene from ARWTConfig
        scene = SCNScene(named: "art.scnassets/ship.scn")!
    }
}
