//
//  MosherScoutingTests.swift
//  MosherScoutingTests
//
//  Created by Gambrell, John on 4/17/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import XCTest

class MosherScoutingTests: XCTestCase {
    var players = [PlayerModel]()
    
    override func setUp() {
        super.setUp()
        let pManager = PlayerManager()
        players = pManager.loadPlayerDataFromPlist()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingPlayerPlistCount() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(players.count, 4)
    }
    
    func testLoadingPlayerPlistData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(players[0].name, "#4 DAK PRESCOTT")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
