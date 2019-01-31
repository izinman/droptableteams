//
//  BoundingBox.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/30/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class BoundingBox: SCNNode {
    let thickness: CGFloat = 0.7
    var isVisible = false
    var fullScale: SCNVector3!
    var halfScale: SCNVector3!
    
    
    private let pulseAction: SCNAction = {
        let pulseOutAction = SCNAction.fadeOpacity(to: 0.2, duration: 0.75)
        let pulseInAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.75)
    
        pulseOutAction.timingMode = .easeInEaseOut
        pulseInAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([pulseOutAction, pulseInAction]))
    }()
    
    private let fluctuateAction: SCNAction = {
        let expandAction = SCNAction.scale(by: 1.05, duration: 0.75)
        let shrinkAction = SCNAction.scale(by: (1/1.05), duration: 0.75)
        
        expandAction.timingMode = .easeInEaseOut
        shrinkAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([shrinkAction, expandAction]))
    }()
    
    init(node: SCNNode) {
        super.init()
        
        let (minVec, maxVec) = node.boundingBox
        let x = CGFloat(maxVec.x - minVec.x)
        let y = CGFloat(maxVec.z - minVec.z)
        let xOffset = Float(x/2.0)
        let yOffset = Float(y/2.0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        
        let posXSegment = makeSegment(w: thickness, h: x, material: material)
        let negXSegment = makeSegment(w: thickness, h: x, material: material)
        let posYSegment = makeSegment(w: y, h: thickness, material: material)
        let negYSegment = makeSegment(w: y, h: thickness, material: material)
        
        posXSegment.position.x += xOffset
        negXSegment.position.x -= xOffset
        posYSegment.position.y += yOffset
        negYSegment.position.y -= yOffset
        
        addChildNode(posXSegment)
        addChildNode(negXSegment)
        addChildNode(posYSegment)
        addChildNode(negYSegment)
        
        transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        
        fullScale = scale
        halfScale = SCNVector3(scale.x * 0.5, scale.y * 0.5, scale.z * 0.5)
        scale = halfScale
        
        opacity = 0.0
        
        node.addChildNode(self)
    }

    func makeSegment(w: CGFloat, h: CGFloat, material: SCNMaterial) -> SCNNode {
        let segment = SCNPlane(width: w, height: h)
        segment.materials = [material]
        return SCNNode(geometry: segment)
    }
    
    func appear() {
        guard !isVisible else { return }
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.4
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0.1, 0.5, 0.5, 1.0)
        SCNTransaction.completionBlock = {
            //self.scale(to: self.fullScale, opacityChange: 0.0)
            self.runAction(self.fluctuateAction, forKey: "fluctuate")
            self.runAction(self.pulseAction, forKey: "pulse")
            self.isVisible = true
        }
        
        opacity = 1.0
        scale.x = fullScale.x * 1.05
        scale.y = fullScale.y * 1.05
        scale.z = fullScale.z * 1.05
        
        SCNTransaction.commit()
    }
    
    func disappear() {
        guard isVisible else { return }
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.3
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        SCNTransaction.completionBlock = {
            self.removeAction(forKey: "pulse")
            self.removeAction(forKey: "fluctuate")
            self.scale(to: self.halfScale, opacityChange: -1.0)
            self.isVisible = false
        }
        
        scale.x = fullScale.x * 1.05
        scale.y = fullScale.y * 1.05
        scale.z = fullScale.z * 1.05
        
        SCNTransaction.commit()
    }
    
    func scale(to: SCNVector3, opacityChange: CGFloat) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.1
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        scale = to
        opacity += opacityChange
        
        SCNTransaction.commit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
