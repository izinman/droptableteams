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
    
    
    var arView = ARSCNView()
    var planes = [UUID : VirtualPlane]()
    var objects = [SCNNode]()
    
    var selectedNode: SCNNode?
    var inPlacementMode = false
    
    var shipNode: SCNNode {
        let scnFileName = "art.scnassets/ship.scn"
        let objectScene = SCNScene(named: scnFileName)!
        let objectNode = objectScene.rootNode.childNode(withName: "ship", recursively: true)!
        let material = SCNMaterial()
        objectNode.geometry?.materials = [material]
        return objectNode
    }
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        // Set the bounds of the view to be the screen
        arView.bounds = UIScreen.main.bounds
        
        arView.delegate = self
        
        // Initialize the AWRTConfig and the scene
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isLightEstimationEnabled = true
        arView.scene = SCNScene()
        
        // Add a tap gesture for object placement and selection
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        // Run the ARView
        arView.session.run(config)
        
        return arView
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let touchLocation = sender.location(in: arView)
        
        if inPlacementMode == true {
            addObject(location: touchLocation)
        } else {
<<<<<<< HEAD
            selectObject(location: touchLocation)
=======
            print("Plane not touched or planes not yet detected")
        }
    }
    
    @objc func addObject(_ node: ARSCNView!,   count: NSNumber) {
        DispatchQueue.main.async {
            self.sceneManager.addObject(objectName: "ship")
>>>>>>> origin/Rotate-Move-React
        }
    }
    @objc func controlObject(_ node: ARSCNView!, control: NSString) {
        print(control)
        //DispatchQueue.main.async {
          //  self.sceneManager.controlObject(controlName: "ship")
        //}
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    func displayDebugInfo() {
        arView.showsStatistics = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
    }
}
