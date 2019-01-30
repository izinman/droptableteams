//
//  ARView+ObjectInteraction.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARView {
    
    func scaleObject(scale: CGFloat) {
        if let node = selectedNode {
            let scaleAction = SCNAction.scale(by: scale, duration: 0.1)
            node.runAction(scaleAction)
        }
    }
    
    func dragObject(gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: self)
        
        if gesture.state == .began, let node = selectedNode {
            prevX = node.worldPosition.x
            prevZ = node.worldPosition.z
        }
        
        if gesture.state == .changed, let node = selectedNode, let result = self.hitTest(location, types: .existingPlane).first {
            
            let newCoordX = result.worldTransform.columns.3.x
            let newCoordZ = result.worldTransform.columns.3.z
            
            let moveAction = SCNAction.moveBy(x: CGFloat(newCoordX - prevX), y: 0, z: CGFloat(newCoordZ - prevZ), duration: 0.1)
            node.runAction(moveAction)
            
            prevX = newCoordX
            prevZ = newCoordZ
            
            gesture.setTranslation(CGPoint.zero, in: self)
        }
        
        if gesture.state == .ended {
            prevX = 0.0
            prevZ = 0.0
        }
    }
    
    func rotateObject(gesture: UIRotationGestureRecognizer) {
        
        guard let node = selectedNode else { return }
        var originalRotation = node.eulerAngles
        if gesture.state == .changed {
            originalRotation.y -= Float(gesture.rotation)
            node.eulerAngles = originalRotation
            gesture.rotation = 0.3 * gesture.rotation
        }
    }
}
