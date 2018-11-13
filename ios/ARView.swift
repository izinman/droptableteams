//
//  ARView.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/12/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import ARKit
import SceneKit
import UIKit

@objc(ARView)
class ARView : ARSCNView {
  
  weak var arViewController: ARViewController?
  
  var config: NSDictionary = [:] {
    didSet {
      setNeedsLayout()
    }
  }
  
  override init(frame: CGRect, options: [String : Any]? = nil) {
    super.init(frame: frame, options: options)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("nope") }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if arViewController == nil {
      embed()
    } else {
      arViewController?.view.frame = bounds
    }
  }
  
  private func embed() {
    guard
      let parentVC = parentViewController else {
        return
    }
    
    let vc = ARViewController()
    parentVC.addChild(vc)
    addSubview(vc.view)
    vc.view.frame = bounds
    vc.didMove(toParent: parentVC)
    self.arViewController = vc
  }
  
}

extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}

