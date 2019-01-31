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
    var xOffset: Float!
    var yOffset: Float!
    var minCorner: SCNVector3!
    var maxCorner: SCNVector3!
    
    init(node: SCNNode) {
        super.init()
        
        let (minVec, maxVec) = node.boundingBox
        let x = CGFloat(maxVec.x - minVec.x)
        let y = CGFloat(maxVec.z - minVec.z)
        xOffset = Float(x/2.0)
        yOffset = Float(y/2.0)
        
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
        
        minCorner = SCNVector3(x: position.x - xOffset, y: 0, z: position.z - yOffset)
        maxCorner = SCNVector3(x: position.x + xOffset, y: 0, z: position.z + yOffset)
        node.addChildNode(self)
    }
    
    func updateCorners() {
        minCorner = SCNVector3(x: position.x - xOffset, y: 0, z: position.z - yOffset)
        maxCorner = SCNVector3(x: position.x + xOffset, y: 0, z: position.z + yOffset)
    }
    
    func makeSegment(w: CGFloat, h: CGFloat, material: SCNMaterial) -> SCNNode {
        let segment = SCNPlane(width: w, height: h)
        segment.materials = [material]
        return SCNNode(geometry: segment)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
