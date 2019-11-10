//
//  testframeworkTests.swift
//  testframeworkTests
//
//  Created by Юрий Нориков on 10.11.2019.
//  Copyright © 2019 norikoff. All rights reserved.
//

import XCTest
@testable import testframework

class testframeworkTests: XCTestCase {
    var array = SynchronizedArray<Int>()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppend() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let defaultQueue = DispatchQueue.global()
        for index in 1...100 {
            defaultQueue.async {
                self.array.append(index)
            }
        }
        XCTAssertEqual(array.count, 100)
    }
    
    
    func testRemove() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        array.append(1)
        XCTAssertEqual(array.count, 1)
        array.removeAll()
        XCTAssertEqual(array.count, 0)
    }
    
}
