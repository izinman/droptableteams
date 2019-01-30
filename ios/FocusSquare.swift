//
//  FocusSquare.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class FocusSquare: SCNNode {
    let size: CGFloat = 0.1
    let segmentWidth: CGFloat = 0.004
    var readyToPlace = false
    var fill: SCNNode?
    var isYellow = true
    
    private let colorMaterial: SCNMaterial = {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        return material
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func enterSearchingMode() {
        guard readyToPlace else { return }
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        for node in childNodes {
            node.geometry?.materials.first?.diffuse.contents = UIColor.yellow
        }
        fill?.opacity = 0.0
        SCNTransaction.completionBlock = { self.readyToPlace = false }
        SCNTransaction.commit()
    }
    
    func enterPlacementMode() {
        guard !readyToPlace else { return }
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        for node in childNodes {
            node.geometry?.materials.first?.diffuse.contents = UIColor.green
        }
        fill?.opacity = 0.6
        SCNTransaction.completionBlock = { self.readyToPlace = true }
        SCNTransaction.commit()
    }
    
    
    private func createSegment(width: CGFloat, height: CGFloat) -> SCNNode {
        let segment = SCNPlane(width: width, height: height)
        segment.materials = [colorMaterial]
        
        return SCNNode(geometry: segment)
    }
    
    private func addHorizontalSegment(dx: Float) {
        let segmentNode = createSegment(width: segmentWidth, height: size)
        segmentNode.position.x += dx
        
        addChildNode(segmentNode)
    }
    
    private func addVerticalSegment(dy: Float) {
        let segmentNode = createSegment(width: size, height: segmentWidth)
        segmentNode.position.y += dy
        
        addChildNode(segmentNode)
    }
    
    private func setup() {
        let dist = Float(size) / 2.0
        addHorizontalSegment(dx: dist)
        addHorizontalSegment(dx: -dist)
        addVerticalSegment(dy: dist)
        addVerticalSegment(dy: -dist)
        
        let square = SCNPlane(width: size, height: size)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        square.materials = [material]
        fill = SCNNode(geometry: square)
        fill?.opacity = 0.0
        addChildNode(fill!)
        
        // Rotate the node so the square is flat against the floor
        transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
    }
}
