//
//  Game.swift
//  FizzBuzz
//
//  Created by Javier Jara on 10/24/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import Foundation

class Game {
    var score : Int
    let brain: Brain
    
    init() {
        score = 0
        brain = Brain()
    }
    
    func play(move: String) -> Bool {
        let result = brain.check(number: score + 1)
        if result == move {
            score += 1
            return true
        } else {
             return false
        }
    }
}
