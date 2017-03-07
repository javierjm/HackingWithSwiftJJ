import UIKit



extension Int {
    mutating func plusOne() {
        self += 1
    }
    
    static func random(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(max - min + 1)) + min
    }
}


var myInt = 0
myInt.plusOne()

var testInt = 10

testInt.plusOne()


