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
    
    func testARSCNManagerInit() {
        XCTAssertNotNil(manager.scene)
        XCTAssertNotNil(manager.ARWTConfig)
        XCTAssert(manager.ARWTConfig.isLightEstimationEnabled == true)
        XCTAssert(manager.ARWTConfig.planeDetection == [.horizontal, .vertical])
        
    }
    
    func testAddObject() {
        let count = manager.scene.rootNode.childNodes.count
        let expectedcount = count + 1
        manager.addObject(objectName: "ship")
        XCTAssert(manager.scene.rootNode.childNodes.count == expectedcount)
    }
    
}
