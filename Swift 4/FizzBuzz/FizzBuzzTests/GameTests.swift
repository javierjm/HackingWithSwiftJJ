//
//  GameTests.swift
//  FizzBuzzTests
//
//  Created by Javier Jara on 10/24/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class GameTests: XCTestCase {
    let game = Game()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScoreIsZero() {
        XCTAssertEqual(game.score, 0)
        XCTAssertTrue(game.score == 0)
    }
    
    func testGamePlayScoreIncremented() {
        let _ = game.play(move: "1")
        XCTAssertTrue(game.score > 0)
    }
    
    func testGamePlayTwiceScoreIncremented(){
        game.score = 1
        let _ = game.play(move: "1")
        XCTAssertTrue(game.score == 1)
    }
    
    func testIfMoveIsRight() {
        game.score = 2
        let result = game.play(move: Constants.fizz)
        XCTAssertEqual(result, true)
    }
    
    func testPlayingFizzOnScoreOneIsFalse() {
        game.score = 1
        let result = game.play(move: Constants.fizz)
        XCTAssertEqual(result, false)
    }
    
    func testPlayingBuzzPass() {
        game.score = 5
        let result = game.play(move: Constants.buzz)
        XCTAssertEqual(result, false)
    }
    
    func testPlayingBuzzFails() {
        game.score = 4
        let result = game.play(move: Constants.buzz)
        XCTAssertEqual(result, true)
    }
    
    func testPlayingFizzBuzzFails() {
        game.score = 30
        let result = game.play(move:Constants.fizzBuzz)
        XCTAssertEqual(result, false)
    }
    
    func testPlayingFizzBuzzPass() {
        game.score = 29
        let result = game.play(move:Constants.fizzBuzz)
        XCTAssertEqual(result, true)
    }
    
    func testPlayingNumberPass() {
        game.score = 30
        let result = game.play(move: "31")
        XCTAssertEqual(result, true)
    }
    
    func testPlayingNumberFails() {
        game.score = 32
        let result = game.play(move: "32")
        XCTAssertEqual(result, false)
    }
    
    func testIfMoveWrongScoreNotIncremented() {
        game.score = 1
        let _ = game.play(move: "Fizz")
        XCTAssertEqual(game.score, 1)
    }
}
