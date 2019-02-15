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
    let thickness: CGFloat = 0.5
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
        let expandAction = SCNAction.scale(to: 1.05, duration: 1.0)
        let shrinkAction = SCNAction.scale(to: 1.0, duration: 1.0)
        
        expandAction.timingMode = .easeInEaseOut
        shrinkAction.timingMode = .easeInEaseOut
        
        return SCNAction.repeatForever(SCNAction.sequence([expandAction, shrinkAction]))
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(node: SCNNode) {
        super.init()
        
        let (minVec, maxVec) = node.boundingBox
        let x = CGFloat(maxVec.x - minVec.x)
        let y = CGFloat(maxVec.z - minVec.z)
        let xOffset = Float(x/2.0)
        let yOffset = Float(y/2.0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        
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
        SCNTransaction.animationDuration = 0.2
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        SCNTransaction.completionBlock = {
            self.bounceIn()
            self.isVisible = true
        }
        
        opacity = 1.0
        scale = SCNVector3(1.05, 1.05, 1.05)
        
        SCNTransaction.commit()
    }
    
    func bounceIn() {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.175
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.1, 0.25, 1.0)
        SCNTransaction.completionBlock = {
            let idleAction = SCNAction.wait(duration: 0.1)
            let pulseAndFluctuate = SCNAction.group([self.pulseAction, self.fluctuateAction])
            self.runAction(SCNAction.sequence([idleAction, pulseAndFluctuate]), forKey: "combined")
        }
        
        scale = SCNVector3(1.0, 1.0, 1.0)
        
        SCNTransaction.commit()
    }
    
    func disappear() {
        guard isVisible else { return }
        
        self.removeAction(forKey: "combined")
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.15
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        SCNTransaction.completionBlock = {
            self.scaleDown()
        }
        
        for node in childNodes {
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        }
        scale = SCNVector3(1.05, 1.05, 1.05)
        
        SCNTransaction.commit()
    }
    
    func scaleDown() {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.15
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        SCNTransaction.completionBlock = {
            for node in self.childNodes {
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            }
            self.isVisible = false
        }
        
        opacity = 0.0
        scale = SCNVector3(0.5, 0.5, 0.5)
        
        SCNTransaction.commit()
    }
    
    
    
    
    
    
    
    
//    func appear() {
//        guard !isVisible else { return }
//        scale(to: SCNVector3(1.05, 1.05, 1.05), opacityChange: 1.0, timing: CAMediaTimingFunctionName.easeOut)
//
//        SCNTransaction.begin()
//        SCNTransaction.animationDuration = 0.15
//        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        SCNTransaction.completionBlock = {
//            self.runAction(SCNAction.group([self.fluctuateAction, self.pulseAction]), forKey: "combined")
//            self.isVisible = true
//        }
//
//        scale = fullScale
//
//        SCNTransaction.commit()
//    }
//
//    func disappear() {
//        guard isVisible else { return }
//
//        SCNTransaction.begin()
//        SCNTransaction.animationDuration = 0.15
//        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        SCNTransaction.completionBlock = {
//            self.removeAction(forKey: "combined")
//            self.scale(to: self.halfScale, opacityChange: -1.0, timing: CAMediaTimingFunctionName.easeIn)
//            self.isVisible = false
//        }
//
//        scale.x = fullScale.x * 1.05
//        scale.y = fullScale.y * 1.05
//        scale.z = fullScale.z * 1.05
//
//        SCNTransaction.commit()
//    }
//
//    func scale(to: SCNVector3, opacityChange: CGFloat, timing: CAMediaTimingFunctionName) {
//        SCNTransaction.begin()
//        SCNTransaction.animationDuration = 0.25
//        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: timing)
//
//        scale = to
//        opacity += opacityChange
//
//        SCNTransaction.commit()
//    }
    
    
}
