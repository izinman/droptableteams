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
    
    var selectedNode: SCNNode?
    var arView = ARSCNView()
    var planes = [UUID : VirtualPlane]()
    var shipNode: SCNNode {
        let scnFileName = "art.scnassets/ship.scn"
        let objectScene = SCNScene(named: scnFileName)!
        let objectNode = objectScene.rootNode.childNode(withName: "ship", recursively: true)!
        return objectNode
    }
    var inPlacementMode = false
    
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
            selectObject(location: touchLocation)
        }
    }
    
    func addObject(location: CGPoint) {
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = arView.hitTest(location, types: .existingPlaneUsingExtent)
        
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first, let identifier = hitResult.anchor?.identifier, planes[identifier] != nil {
            // Create an object to place
            let ship = shipNode.clone()
            
            // Adjust the orientation and placement so it sits on the plane
            let rotation = simd_float4x4(SCNMatrix4MakeRotation(arView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
            let hitTransform = simd_mul(hitResult.worldTransform, rotation)
            ship.transform = SCNMatrix4(hitTransform)
            ship.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            
            // Add the object to the scene
            arView.scene.rootNode.addChildNode(ship)
        }
        
        inPlacementMode = false
    }
    
    func selectObject(location: CGPoint) {
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = arView.hitTest(location, options: nil)
        
        // Check that the node is not null and select it
        if let node = nodeHits.last?.node {
            // Rotate Right
            node.runAction(SCNAction.rotateBy(x: 0, y: 20, z: 0, duration: 0))
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
        }
    }
    
    
    @objc func enterPlacementMode(_ node: ARSCNView!,  count: NSNumber) {
        inPlacementMode = true
    }
    
    func displayDebugInfo() {
        arView.showsStatistics = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
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
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
