//
//  ARViewManager+Gestures.swift
//  FreeRealEstate
//
//

import Foundation
import ARKit
import SceneKit

extension ARViewManager {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Get the location tapped by the user
        let location = gesture.location(in: arView)
        
        // Perform a hit test to obtain the node the user tapped on
        let nodeHits = arView.hitTest(location, options: nil)
        
        // Check that the node is not null and that it represents a user placed object
        if let node = nodeHits.first?.node, arViewModel.objects.contains(node) {
            
            // If an object was already selected, make its selection box disappear and delay the appearance of a new one
            var delayAppear = 0.0
            if let prevSelectedNode = arViewModel.selectedNode {
                if node == prevSelectedNode { return }
                
                arViewModel.selectionBoxes[prevSelectedNode]?.disappear()
                delayAppear = 0.2
            }
            
            // Select the node and get a reference to its selection box
            arViewModel.selectedNode = node
            var selectionBox = arViewModel.selectionBoxes[node]
            
            // If the node had not yet been selected, initialize a new selection box and store the reference
            if selectionBox == nil {
                selectionBox = BoundingBox(node: node)
                arViewModel.selectionBoxes[node] = selectionBox
            }
            
            // Make the focusSquare disappear and render the selection box
            arView.focusSquare?.disappear()
            selectionBox?.runAction(SCNAction.wait(duration: delayAppear), completionHandler: { selectionBox?.appear() })
            
            showAdjustmentButtons()
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        // Make sure an object has been selected
        guard let node = arViewModel.selectedNode else { return }
        
        // Get the location the most recent touch and perform a hit test
        let location = gesture.location(in: arView)
        guard let result = arView.hitTest(location, types: .existingPlane).first else { return }
        
        // Store the coordinates of the new location
        let newCoordX = result.worldTransform.columns.3.x
        let newCoordZ = result.worldTransform.columns.3.z
        
        // If this is the first touch, initialize the original coordinates to be that of the touch
        if gesture.state == .began {
            arViewModel.prevX = newCoordX
            arViewModel.prevZ = newCoordZ
        }
        
        // Otherwise, if the user has moved their finger
        if gesture.state == .changed {
            
            let distance = getDistance(from: node, to: result)
            
            // Move the node by the distance between this touch and the previous touch
            let moveAction = SCNAction.moveBy(x: CGFloat(newCoordX - arViewModel.prevX), y: 0, z: CGFloat(newCoordZ - arViewModel.prevZ), duration: 0.1)
            node.runAction(moveAction)
            sendUpdate(node: node, name: nil, x: newCoordX - arViewModel.prevX, y: nil, z: newCoordZ - arViewModel.prevZ, rotation: nil)
            //sendNodeUpdate(forNode: node, withAction: moveAction)
            
            // Update the coordinates before processing more touches
            arViewModel.prevX = newCoordX
            arViewModel.prevZ = newCoordZ
            
            // Necessary to prevent exponential movement
            gesture.setTranslation(CGPoint.zero, in: arView)
        }
        
        // The user is done dragging the object, reset the coordinates
        if gesture.state == .ended {
            arViewModel.prevX = 0.0
            arViewModel.prevZ = 0.0
        }
    }
    
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        // Make sure an object has been selected
        guard let node = arViewModel.selectedNode else { return }
        
        // Adjust the nodes rotation around the y axis by the amount the user has moved their fingers
        if gesture.state == .changed {
            let rotateAction = SCNAction.rotateBy(x: 0, y: -gesture.rotation, z: 0, duration: 0.1)
            node.runAction(rotateAction)
            sendUpdate(node: node, name: nil, x: nil, y: nil, z: nil, rotation: Float(-gesture.rotation))
            //sendNodeUpdate(forNode: node, withAction: rotateAction)
            //node.eulerAngles.y -= Float(gesture.rotation)
            gesture.rotation = 0//.3 * gesture.rotation
        }
    }
    
    func getDistance(from: SCNNode, to: ARHitTestResult) -> Float {
        let tmpNode = SCNNode()
        let hitPosition = SCNVector3(to.worldTransform.columns.3.x, to.worldTransform.columns.3.y, to.worldTransform.columns.3.z)
        tmpNode.position = hitPosition
        let nodePosition = from.convertPosition(from.position, to: tmpNode)
        
        let dx = hitPosition.x - nodePosition.x
        let dz = hitPosition.z - nodePosition.z
        
        return sqrtf(dx * dx + dz * dz)
    }
}
