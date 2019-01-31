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
    var length: CGFloat!
    var width: CGFloat!
    
    init(node: SCNNode) {
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
