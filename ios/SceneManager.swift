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
    var ARWTConfig: ARWorldTrackingConfiguration!
    
    override init() {
        super.init()
        initARWTConfig(config: nil)
        initScene()
    }
    
    func initARWTConfig(config: ARWorldTrackingConfiguration?) {
        // Check if we are loading an existing config -- if not, create a new one
        let configuration = (config != nil) ? config : ARWorldTrackingConfiguration()
        configuration?.planeDetection = [.horizontal, .vertical]
        configuration?.isLightEstimationEnabled = true
        ARWTConfig = configuration
    }
    
    func initScene() {
        // TODO: Figure out how to load a scene from ARWTConfig
        scene = SCNScene()
    }
    
    func addObject(objectName: String) {
        let scnFileName = "art.scnassets/" + objectName + ".scn"
        let objectScene = SCNScene(named: scnFileName)!
        
        let objectNode = objectScene.rootNode.childNode(withName: objectName, recursively: true)!
        objectNode.position = SCNVector3(0, 0, 0)
    
        scene.rootNode.addChildNode(objectNode)
    }
}
