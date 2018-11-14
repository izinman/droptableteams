//
//  ARVCPresenter.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/13/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc(ARVCPresenter)
class ARVCPresenter : NSObject {
    
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc
    func presentARVC() {
        let rootVC = UIApplication.shared.keyWindow!.rootViewController as! UIViewController
        let arVC = ARViewController()
        
        arVC.view.frame = rootVC.view.bounds
        rootVC.present(arVC, animated: false, completion: nil)
        arVC.didMove(toParent: rootVC)
    }
}

