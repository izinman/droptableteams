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
    
    var firstObjectPlaced = false
    var selectedNode: SCNNode?
    var arView = ARSCNView()
    var sceneManager = ARSCNManager()
    var planes = [UUID : VirtualPlane]()
    var shipNode: SCNNode {
        let scnFileName = "art.scnassets/ship.scn"
        let objectScene = SCNScene(named: scnFileName)!
        let objectNode = objectScene.rootNode.childNode(withName: "ship", recursively: true)!
        return objectNode
    }
    
    // Returns an ARSCNView for React to present
    override func view() -> UIView {
        
        // Set the bounds of the view to be the screen
        arView.bounds = UIScreen.main.bounds
        
        // Get the scene and config from the SceneManager
        arView.delegate = self
        arView.scene = sceneManager.getScene()
        let config = sceneManager.getConfig()
        displayDebugInfo()
        
        // Run the ARView
        arView.session.run(config)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(scnTapped(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    @objc func scnTapped(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: arView)
        let hits = arView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        let nodeHits = arView.hitTest(touchLocation, options: nil)
        print("object touched")
        if hits.count > 0, let hitResult = hits.first, let identifier = hitResult.anchor?.identifier, planes[identifier] != nil, !firstObjectPlaced {
            let ship = shipNode.clone()
            let rotation = simd_float4x4(SCNMatrix4MakeRotation(arView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
            let hitTransform = simd_mul(hitResult.worldTransform, rotation)
            ship.transform = SCNMatrix4(hitTransform)
            
            print("object touched 1")

            ship.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            sceneManager.scene.rootNode.addChildNode(ship)
            firstObjectPlaced = true
            selectedNode = ship
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))

        } else if let node = nodeHits.last?.node, node == selectedNode {
            print("object touched 2")

            // Rotate Right
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
            /*
            // Rotate Left
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
            
            // Move Left
            selectedNode?.runAction(SCNAction.moveBy(x: -0.01, y: 0, z: 0, duration: 0))
            
            // Move Right
            selectedNode?.runAction(SCNAction.moveBy(x: 0.01, y: 0, z: 0, duration: 0))
            
            // Move Forward
            selectedNode?.runAction(SCNAction.moveBy(x: 0, y: 0, z: 0.01, duration: 0))
            
            // Move Backward
            selectedNode?.runAction(SCNAction.moveBy(x: 0, y: 0, z: -0.01, duration: 0))
            */
        } else {
            print("Plane not touched or planes not yet detected")
        }
    }
    
    @objc func addObject(_ node: ARSCNView!,   count: NSNumber) {
        DispatchQueue.main.async {
            self.sceneManager.addObject(objectName: "ship")
        }
    }
    @objc func controlObject(_ node: ARSCNView!, control: NSString) {
        print(control)
        //DispatchQueue.main.async {
          //  self.sceneManager.controlObject(controlName: "ship")
        //}
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(arPlaneAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = planes.index(forKey: arPlaneAnchor.identifier) {
            planes.remove(at: index)
        }
    }
    
    func displayDebugInfo() {
        arView.showsStatistics = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
