//
//  ARViewManager+ObjectPlacement.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARViewManager {
    
    @objc func setObjectToPlace(_ node: ARSCNView!, objectName: String) {
        arViewModel.objectToPlace = objectName
        print("\n\n SETOBJECTTOPLACE SWIFT IS BEING CALLED\n\n")
    }
    
    @objc func placeObject(_ node: ARSCNView!) {
        guard let focusSquare = arView.focusSquare, focusSquare.canPlace else { return }
        // Perform a hit test to obtain the plane on which we will place the object
        let planeHits = arView.hitTest(arView.center, types: .existingPlane)
        
        // Verify that the plane is valid
        if planeHits.count > 0, let hitResult = planeHits.first {
            // Create an object to place
            guard let newNode = createNode(objName: arViewModel.objectToPlace, hitResult: hitResult) else { return }
            newNode.opacity = 0.0
            
            let appearAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.2)
            appearAction.timingMode = .easeInEaseOut
            
            sendNodeUpdate(forNode: newNode, withAction: appearAction)
            
            // Done after sendNodeUpdate so that nil isn't sent and gives the receiver a head start on placing
            // Add the object to the scene
            var hasher = Hasher()
            hasher.combine(newNode)
            let hashValue = Int64(hasher.finalize())
            
            arViewModel.objectHashTable[hashValue] = newNode
            arViewModel.objects.append(newNode)
            
            arView.scene.rootNode.addChildNode(newNode)
            newNode.runAction(appearAction)
        }
    }
    
    func createNode(objName: String?, hitResult: ARHitTestResult) -> SCNNode? {
        
        // Create a node object from the .scn file
        guard let name = objName else { return nil }
        let scnFileName = "art.scnassets/" + name + ".scn"
        print("name" + name)
        guard let tmpScene = SCNScene(named: scnFileName) else { return nil }
        
        var child_node = ""
        if(name == "chair_2"){
            child_node = "pillow_fabric"
        }
        else if(name == "couch_1"){
            child_node = "Box002"
        }
        else if (name == "couch_2"){
            child_node = "Obj3d66_512505_1_864_wire_000000000"
        }
        else if(name == "couch_3"){
            child_node = "andango_arm_wire_088144225"
        }
        else {
            child_node = "_material_1"
        }
        
        let node = tmpScene.rootNode.childNode(withName: child_node, recursively: true)!
        
        // Initialize rotation value to ensure the object will be properly oriented
        let rotation = simd_float4x4(SCNMatrix4MakeRotation(arView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
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
        node.scale = arViewModel.ObjScaleMap[name]!
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        node.geometry?.firstMaterial?.lightingModel = .physicallyBased
        node.categoryBitMask = arViewModel.objectLightingMask
        
        return node
    }

    @objc func confirmAdjustment() {
        if let node = arViewModel.selectedNode {
            arViewModel.selectionBoxes[node]?.disappear()
            arViewModel.selectedNode = nil
            arView.focusSquare?.appear()
            hideAdjustmentButtons()
        }
    }
    
    @objc func removeObject() {
        if let node = arViewModel.selectedNode, let index = arViewModel.objects.index(of: node) {
            let fadeAction = SCNAction.fadeOpacity(to: 0.0, duration: 0.15)
            fadeAction.timingMode = SCNActionTimingMode.easeInEaseOut
            arViewModel.selectionBoxes[node]?.disappear()
            node.runAction(fadeAction, completionHandler: {
                self.arViewModel.selectedNode = nil
                self.arViewModel.objects.remove(at: index)
                self.arViewModel.selectionBoxes.removeValue(forKey: node)
                node.removeFromParentNode()
            })
            
            arView.focusSquare?.appear()
            hideAdjustmentButtons()
        }
    }
}
