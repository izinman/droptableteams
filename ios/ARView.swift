//
//  ARView.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/25/19.
//  Copyright © 2019 Facebook. All rights reserved.
//
import Foundation
import ARKit
import SceneKit

class ARView : ARSCNView, ARSCNViewDelegate {
    
    var objects = [SCNNode]()
    var selectedNode: SCNNode?
    var planeDetected = false
    
    var focusSquare: FocusSquare?
    
    var prevX: Float = 0.0
    var prevZ: Float = 0.0
    
    var onObjectSelect: RCTDirectEventBlock?
    var cameraVector: simd_float3 {
        return session.currentFrame!.camera.eulerAngles
    }
    
    let ObjScaleMap: [String: SCNVector3] = [
        "chair": SCNVector3(x: 0.02, y: 0.02, z: 0.02),
        "vase": SCNVector3(x: 0.0015, y: 0.0015, z: 0.0015),
        "table_2": SCNVector3(x: 0.01, y: 0.01, z: 0.01),
        "coffee_table": SCNVector3(x: 0.25, y: 0.25, z: 0.25)
    ]
    
    func createNode(name: String, hitResult: ARHitTestResult) -> SCNNode {
        // Create a node object from the .scn file
        let scnFileName = "art.scnassets/" + name + ".scn"
        let tmpScene = SCNScene(named: scnFileName)!
        let node = tmpScene.rootNode.childNode(withName: "_material_1", recursively: true)!
        
        // Initialize rotation value to ensure the object will be properly oriented
        let rotation = simd_float4x4(SCNMatrix4MakeRotation(self.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
        let hitTransform = simd_mul(hitResult.worldTransform, rotation)
        
        // Get the bounding box values to set the pivot to be at the center of the node
        var minVec = SCNVector3Zero
        var maxVec = SCNVector3Zero
        (minVec, maxVec) =  node.boundingBox
        
        // Set the nodes pivot appropriately
        node.pivot = SCNMatrix4MakeTranslation(
            minVec.x + (maxVec.x - minVec.x)/2,
            minVec.y,
            minVec.z + (maxVec.z - minVec.z)/2
        )
        
        // Scale, rotate, and place the node so it sits on the plane
        node.transform = SCNMatrix4(hitTransform)
        node.scale = ObjScaleMap[name]!
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        return node
    }
    
    func addObject(name: String) {
        
        guard let focusSquare = focusSquare, planeDetected else { return }
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = hitTest(center, types: .existingPlane)
        
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first {
            // Create an object to place
            let node = createNode(name: name, hitResult: hitResult)
            node.opacity = 0.0
            
            // Add the object to the scene
            scene.rootNode.addChildNode(node)
            objects.append(node)
            
            let appearAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.2)
            appearAction.timingMode = .easeInEaseOut
            node.runAction(appearAction)
        }
    }
    
    func selectObject(location: CGPoint) {
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = self.hitTest(location, options: nil)
        
        // Check that the node is not null and select it
        if let node = nodeHits.first?.node, objects.contains(node) {
            // If we had previously selected an object, unhighlight it before selecting a new one
            if (selectedNode != nil) {
                selectedNode?.removeAction(forKey: "pulse")
                selectedNode?.runAction(SCNAction.fadeOpacity(to: 1.0, duration: 0.75))
                
                if node == selectedNode {
                    selectedNode = nil
                    return
                }
            }
            
            // Select the node and mark it visually by reducing the opacity
            selectedNode = node
            
            let fadeOutAction = SCNAction.fadeOpacity(to: 0.6, duration: 1.0)
            let fadeInAction = SCNAction.fadeOpacity(to: 1.0, duration: 1.0)
            fadeInAction.timingMode = .easeInEaseOut
            
            let pulseAction = SCNAction.repeatForever(SCNAction.sequence([fadeOutAction, fadeInAction]))
            
            node.runAction(pulseAction, forKey: "pulse")
            
            // Tell React to display adjustment button menu
            onObjectSelect!([:])
        }
    }
    
    func displayDebugInfo() {
        self.showsStatistics = true
        self.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
    }
}
