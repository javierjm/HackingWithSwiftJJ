//
//  Brain.swift
//  FizzBuzz
//
//  Created by Javier Jara on 10/20/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import Foundation

class Brain {
    
    func isDivisibleByThree(number: Int) -> Bool {
        return isDivisibleBy(divisor: 3, number: number)
    }
    
    func isDivisibleByFive(number: Int) -> Bool {
        return isDivisibleBy(divisor: 5, number: number)
    }
    
    func isDivislbeByThreeAndFive(number:Int)-> Bool {
        return isDivisibleBy(divisor: 15, number: number)
    }
    
    func isDivisibleBy(divisor: Int, number: Int) -> Bool {
        return number % divisor == 0
    }
    
    func check(number: Int) -> String {
        if isDivislbeByThreeAndFive(number: number){
            return Constants.fizzBuzz
        }
        
        if isDivisibleByFive(number: number) {
            return Constants.buzz
        }
        if isDivisibleByThree(number: number){
            return Constants.fizz
        }

        return "\(number)"
    }
    
}
