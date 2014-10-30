//
//  SycamoreAPITests.swift
//  SycamoreAPITests
//
//  Created by Drew Rosenberg on 10/20/14.
//  Copyright (c) 2014 Drew Rosenberg. All rights reserved.
//

import UIKit
import XCTest

class SycamoreAPITests: XCTestCase {
    
    let sycamoreConnection = Sycamore()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

/*
class SycamoreTokenTests: XCTestCase {
    let realToken = "2964b59302860ae018608aadcece3a49f1f4d6e4"
    let fakeToken = "2964b59302860ae018608aadcece3a49f1f4d6e"
    
    func testGoodTokenReceived(){
        let fake_token = "123456"
        self.sycamoreConnection.receive_token(fake_token)
        XCTAssert(self.sycamoreConnection.authentication_token == fake_token, "Token not received properly")
    }
    
    func testNilTokenReceived(){
        let fake_token : String? = nil
        Sycamore.receive_token(fake_token)
        XCTAssert(Sycamore.authentication_token == nil, "empty token not handled properly")
    }
    
    func testLocalToken(){
        Sycamore.request_token()
        XCTAssert(Sycamore.authentication_token != nil, "no token has been saved to user defaults")
    }
    
}
*/
