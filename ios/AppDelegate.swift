//
//  AppDelegate.swift
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/9/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate : UIResponder, UIApplicationDelegate {
  
    // Create the base window
    var window : UIWindow? = UIWindow(frame: UIScreen.main.bounds)
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
        // Setup any initial properties we want included
        let initialProperties: [String: Any] = [:]
      
        // Define the name of the initial module
        let moduleName = "FreeRealEstate"
      
        let jsCodeLocation = Bundle.main.url(forResource:"main", withExtension: "jsbundle")
      
        let view = RCTRootView(bundleURL:jsCodeLocation as URL!, moduleName: moduleName, initialProperties: initialProperties, launchOptions:launchOptions)
        view?.backgroundColor = UIColor.white
      
        // TO RE-ENABLE JAVASCRIPT OVER THE WIRE (AND HOT REFRESHES) UNCOMMENT THE FOLLOWING AND COMMENT THE ABOVE
      
        // Define the url that will be used to find the entry file
      /*
        let bundleURL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
       
        // Create the React Native view that will render the module with the properties
        let view = RCTRootView(bundleURL: bundleURL, moduleName: moduleName, initialProperties: initialProperties, launchOptions: launchOptions)

        view?.backgroundColor = UIColor.white
       */
        // Create the controller to display the view
        let controller = UIViewController()
        controller.view = view
      
        // Add the controller to the window
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
      
        return true
    }
}
