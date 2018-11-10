//
//  AppDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/9/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var bridge: RCTBridge!
  
  private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    /**
     * Loading JavaScript code - uncomment the one you want.
     *
     * OPTION 1
     * Load from development server. Start the server from the repository root:
     *
     * $ npm start
     *
     * To run on device, change `localhost` to the IP address of your computer
     * (you can get this by typing `ifconfig` into the terminal and selecting the
     * `inet` value under `en0:`) and make sure your computer and iOS device are
     * on the same Wi-Fi network.
     */
    
    let jsCodeLocation = NSURL(string: "http://localhost:8081/index.ios.bundle?platform=ios&dev=true")
    
    let rootView = RCTRootView(bundleURL:jsCodeLocation! as URL, moduleName: "SwiftReactNative", initialProperties: nil, launchOptions:launchOptions)
    
    self.bridge = rootView?.bridge
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    
    rootViewController.view = rootView
    
    self.window!.rootViewController = rootViewController;
    self.window!.makeKeyAndVisible()
    
    return true
  }
}
