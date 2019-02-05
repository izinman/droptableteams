//
//  ARView+ARSCNViewDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 1/25/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ARKit
import SceneKit

extension ARView {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = VirtualPlane(anchor: planeAnchor)
        
        planes[planeAnchor.identifier] = plane
        
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let plane = planes[planeAnchor.identifier]
            else { return }
        
        plane.updateWithNewAnchor(planeAnchor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let index = planes.index(forKey: planeAnchor.identifier)
            else { return }
        
        planes.remove(at: index)
    }
}
