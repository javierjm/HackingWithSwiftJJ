//
//  BrainTests.swift
//  FizzBuzzTests
//
//  Created by Javier Jara on 10/20/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import XCTest
@testable import FizzBuzz


class BrainTests: XCTestCase {
    let brain = Brain()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsDivisibleByThree() {
        let result = brain.isDivisibleByThree(number: 3)
        XCTAssertEqual(result, true)
    }
    
    func testIsNotDivisibleByThree() {
        let result = brain.isDivisibleByThree(number: 1)
        XCTAssertEqual(result, false)
    }
    
    func testFiveIsDivisibleByFive() {
        let result = brain.isDivisibleByFive(number:5)
        XCTAssertEqual(result, true)
    }
    
    func testIsNotDivisibleByFive(){
        let result = brain.isDivisibleByFive(number:2)
        XCTAssertEqual(result, false)
    }
    
    func testIsDivisibleByThreeAndFive() {
        let result = brain.isDivislbeByThreeAndFive(number:30)
        XCTAssertEqual(result, true)
    }
    
    func testSayFizz() {
        let result = brain.check(number: 3)
        XCTAssertEqual(result, Constants.fizz)
    }
    
    func testSayBuzz() {
        let result = brain.check(number: 5)
        XCTAssertEqual(result, Constants.buzz)
        
    }
    
    func testSayFizzBuzz() {
        let result = brain.check(number: 30)
        XCTAssertEqual(result, Constants.fizzBuzz)
    }
    
    
    func testSayNumber() {
        let result = brain.check(number:1)
        XCTAssertEqual(result, "1")
    }
}
