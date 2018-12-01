//
//  ARSCNManagerTests.swift
//  FreeRealEstateTests
//
//  Created by Isaac Zinman on 11/28/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import XCTest
@testable import FreeRealEstate

class ARSCNManagerTests: XCTestCase {
  
    var manager: ARSCNManager!
    
    // Initialize a new ARSCNManager at the beginning of each test
    override func setUp() {
        manager = ARSCNManager()
    }
    
    override func tearDown() {
        manager = nil
    }
    //
    
    func test_init() {
        XCTAssertNotNil(manager.scene)
        XCTAssertNotNil(manager.arwtConfig)
        XCTAssert(manager.arwtConfig.isLightEstimationEnabled == true)
        XCTAssert(manager.arwtConfig.planeDetection == [.horizontal, .vertical])
        
    }
    
    func test_getScene() {
        // Should be nonnull scene after init
        XCTAssertNotNil(manager.getScene())
        // Set it to nil and test that it now returns nil
        manager.scene = nil
      
        XCTAssertNil(manager.getScene())
    }
    
    func test_getConfig() {
      // Should be nonnull config after init
      XCTAssertNotNil(manager.getConfig())
      // Test that it returns nil after being manually set
      manager.arwtConfig = nil
      
      XCTAssertNil(manager.getConfig())
      
    }
    
    func test_addObject() {
      
        let count = manager.scene.rootNode.childNodes.count
        let expectedcount = count + 1
      
        manager.addObject(objectName: "ship")
      
        XCTAssert(manager.scene.rootNode.childNodes.count == expectedcount)
    }
    
}
