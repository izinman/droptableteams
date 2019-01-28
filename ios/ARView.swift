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
    
    var planes = [UUID : VirtualPlane]()
    var objects = [SCNNode]()
    
    var selectedNode: SCNNode?
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
        
        // Scale, rotate, and place the node so it sits on the plane
        node.transform = SCNMatrix4(hitTransform)
        node.scale = ObjScaleMap[name]!
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        return node
    }
    
    func addObject(location: CGPoint, name: String) {
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = self.hitTest(location, types: .existingPlaneUsingExtent)
        
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first, let identifier = hitResult.anchor?.identifier, planes[identifier] != nil {
            // Create an object to place
            let node = createNode(name: name, hitResult: hitResult)
            
            // Add the object to the scene
            self.scene.rootNode.addChildNode(node)
            objects.append(node)
        }
    }
    
    func selectObject(location: CGPoint) {
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = self.hitTest(location, options: nil)
        
        // Check that the node is not null and select it
        if let node = nodeHits.first?.node, objects.contains(node) {
            // If we had previously selected an object, unhighlight it before selecting a new one
            if (selectedNode != nil) {
                selectedNode?.opacity = 1.0
            }
            
            // Select the node and mark it visually by reducing the opacity
            selectedNode = node
            selectedNode?.opacity = 0.7
            // Tell React to display adjustment button menu
            onObjectSelect!([:])
        }
    }
    
    // Necessary for React Native to recognize object selection event emitter
    @objc func setOnObjectSelect(_ val: @escaping RCTDirectEventBlock) {
        onObjectSelect = val
    }
    
    func getAdjustedCordinates(x: Float, z: Float) -> (CGFloat, CGFloat) {
        // z2 = cosβz_1 − sinβx_1
        // x2 = sinβz_1 + cosβx_1
        let beta: Float = cameraVector.y;
        let adjustedZ = CGFloat(cos(beta) * z - sin(beta) * x)
        let adjustedX = CGFloat(sin(beta) * z + cos(beta) * x)
        
        return (adjustedX, adjustedZ)
    }
    
    func adjustObject(buttonPressed: String) {
        
        switch (buttonPressed) {
            
        case "rotateRight":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0))
            
        case "rotateLeft":
            selectedNode?.runAction(SCNAction.rotateBy(x: 0, y: 0.1, z: 0, duration: 0))
            
        case "moveLeft":
            let adjustedCorrdinates = getAdjustedCordinates(x: -0.01, z: 0)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCorrdinates.0, y: 0, z: adjustedCorrdinates.1, duration: 0))
            
        case "moveRight":
            let adjustedCorrdinates = getAdjustedCordinates(x: 0.01, z: 0)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCorrdinates.0, y: 0, z: adjustedCorrdinates.1, duration: 0))
            
        case "moveForward":
            let adjustedCorrdinates = getAdjustedCordinates(x: 0, z: -0.01)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCorrdinates.0, y: 0, z: adjustedCorrdinates.1, duration: 0))
            
        case "moveBackward":
            let adjustedCorrdinates = getAdjustedCordinates(x: 0, z: 0.01)
            selectedNode?.runAction(SCNAction.moveBy(x: adjustedCorrdinates.0, y: 0, z: adjustedCorrdinates.1, duration: 0))
            
        case "confirmPlacement":
            selectedNode?.opacity = 1.0
            selectedNode = nil
            
        case "deleteObject":
            if let node = selectedNode, let index = objects.index(of: node) {
                objects.remove(at: index)
                node.removeFromParentNode()
            }
            selectedNode = nil
            
        default:
            return
        }
    }
    
    func displayDebugInfo() {
        self.showsStatistics = true
        self.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // , ARSCNDebugOptions.showWorldOrigin]
    }
}
