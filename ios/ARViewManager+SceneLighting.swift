//
//  ARViewManager+SceneLighting.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 2/13/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import UIKit

extension ARViewManager {
    
    func createDirectionalLight(){
        let scnLight = SCNNode()
        scnLight.light = SCNLight()
        scnLight.scale = SCNVector3(1,1,1)
        scnLight.light?.intensity = 1000
        scnLight.castsShadow = true
        scnLight.position = SCNVector3(0, 0.5, 0)
        scnLight.light?.type = SCNLight.LightType.directional
        scnLight.light?.color = UIColor.white
        scnLight.light?.categoryBitMask = arViewModel.objectLightingMask
        
        arViewModel.sceneLight = scnLight
        arView.scene.rootNode.addChildNode(scnLight)
    }
    
    func setupDirectionalLighting(queue: DispatchQueue) {
        guard arViewModel.lightingRootNode == nil else {
            return
        }
        
        // Add directional lighting for dynamic highlights in addition to environment-based lighting.
        guard let lightingScene = SCNScene(named: "lighting.scn", inDirectory: "art.scnassets", options: nil) else {
            print("Error setting up directional lights: Could not find lighting scene in resources.")
            return
        }
        
        let lightingRootNode = SCNNode()
        lightingRootNode.name = "lightingRootNode"
        
        for node in lightingScene.rootNode.childNodes where node.light != nil {
            lightingRootNode.addChildNode(node)
        }
        
        queue.async {
            self.arView.scene.rootNode.addChildNode(lightingRootNode)
        }
    }
    
    func updateDirectionalLighting(intensity: CGFloat, queue: DispatchQueue) {
        guard let lightingRootNode = arViewModel.lightingRootNode else {
            return
        }
        
        queue.async {
            for node in lightingRootNode.childNodes {
                node.light?.intensity = intensity
            }
        }
    }
}
