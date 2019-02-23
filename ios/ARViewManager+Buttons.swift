//
//  ARViewManager+Buttons.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 2/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import SceneKit

extension ARViewManager {
  func addPlaceButton() {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 160, y: 550, width: 60, height: 60)
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    button.clipsToBounds = true
    button.setImage(UIImage(named:"art.scnassets/place-button.png"), for: .normal)
    button.addTarget(self, action: #selector(placeObject), for: .touchUpInside)
    button.alpha = 0.0
    button.isEnabled = false
    arView.addSubview(button)
    arView.placeButton = button
    showPlaceButton()
  }
  
  func addConfirmButton() {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 160, y: 550, width: 60, height: 60)
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    button.clipsToBounds = true
    button.setImage(UIImage(named:"art.scnassets/confirm-button.png"), for: .normal)
    button.addTarget(self, action: #selector(confirmAdjustment), for: .touchUpInside)
    button.alpha = 0.0
    button.isEnabled = false
    arView.addSubview(button)
    arView.confirmButton = button
  }
  
  func addRemoveButton() {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 160, y: 550, width: 60, height: 60)
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    button.clipsToBounds = true
    button.setImage(UIImage(named:"art.scnassets/remove-button.png"), for: .normal)
    button.addTarget(self, action: #selector(removeObject), for: .touchUpInside)
    button.alpha = 0.0
    button.isEnabled = false
    arView.addSubview(button)
    arView.removeButton = button
  }
  
  func showPlaceButton() {
    UIView.animate(withDuration: 0.15,
                   animations: { self.arView.placeButton.alpha = 1.0},
                   completion: { _ in self.arView.placeButton.isEnabled = true })
  }
  
  func hidePlaceButton() {
    arView.placeButton.isEnabled = false
    UIView.animate(withDuration: 0.1,
                   animations: { self.arView.placeButton.alpha = 0.0 })
  }
  
  func showAdjustmentButtons() {
    hidePlaceButton()
    UIView.animate(withDuration: 0.2, delay: 0.1,
                   animations: {
                    self.arView.confirmButton.alpha = 1.0
                    self.arView.removeButton.alpha = 1.0
                    self.arView.confirmButton.frame = CGRect(x: 100, y: 550, width: 60, height: 60)
                    self.arView.removeButton.frame = CGRect(x: 220, y: 550, width: 60, height: 60)
    },
                   completion: { _ in
                    self.arView.confirmButton.isEnabled = true
                    self.arView.removeButton.isEnabled = true
    })
  }
  
  func hideAdjustmentButtons() {
    arView.confirmButton.isEnabled = false
    arView.removeButton.isEnabled = false
    UIView.animate(withDuration: 0.05, delay: 0.15,
                   animations: {
                    self.arView.confirmButton.alpha = 0.0
                    self.arView.removeButton.alpha = 0.0 })
    UIView.animate(withDuration: 0.2,
                   animations: {
                    self.arView.confirmButton.frame = CGRect(x: 160, y: 550, width: 60, height: 60)
                    self.arView.removeButton.frame = CGRect(x: 160, y: 550, width: 60, height: 60) },
                   completion: { _ in
                    self.showPlaceButton() })
  }
}
