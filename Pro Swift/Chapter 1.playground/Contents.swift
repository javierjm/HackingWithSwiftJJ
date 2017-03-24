//: Playground - noun: a place where people can play

import UIKit

print("******************************************************************** Pattern Matching ********************************************************************")

// Refers to the ability to match tuples in switch statement 

// Partial Matching: 

// use _ to ignore part of the tuple
let authentication = (name: "twostraws", password: "fr0st1es", ipAddress: "127.0.0.1")
switch authentication {
case ("bilbo", "bagg1n5", _):
    print("Hello, Bilbo Baggins!")
    // Use let to request an unknown value from the tuple, and _ to ignore a part
case ("twostraws", let password, _):
    print("Hello, Paul Hudson! your password is: \(password)")
default:
    print("Who are you?")
}

print("******************************************************************** Loops ********************************************************************")


let twostraws = (name: "twostraws", password: "fr0st1es")
let bilbo = (name: "bilbo", password: "bagg1n5")
let taylor = (name: "taylor", password: "fr0st1es")
let users = [twostraws, bilbo, taylor]

for user in users {
    print(user.name)
}

// We can use case statement in Loop for pattern matching: 

for case ("twostraws", "fr0st1es") in users {
        print("User twostraws has the password fr0st1es")
}

// or can combine a bind value and match the other in one pair of parenthesis: 

for case let (name, "fr0st1es") in users {
    print("User \(name) has the password \"fr0st1es\"")
}

print("******************************************************************** Matching Optionals ********************************************************************")

let name: String? = "twostraws"
let password: String? = "fr0st1es"

// Option 1 using .some and .none keywords, notice inside parenthesis the vale is unwrapped so is not optional anymore 

switch (name, password) {
case let (.some(nameUnwrapped), .some(passwordUnwrapped)):
    print("Hello, \(nameUnwrapped)")
case let (.some(nameUnwrapped), .none):
    print("Please enter a password.")
default:
    print("Who are you?")
}
// Option 2: using optional unwrapping

switch (name, password) {
case let (nameUnwrapped?, passwordUnwrapped?):
    print("Hello, \(nameUnwrapped)")
case let (nameUnwrapped?, nil):
    print("Please enter a password.")
default:
    print("Who are you?")
}

// Same approach for Loops 

import Foundation

let data: [Any?] = ["Bill", nil, 69, "Ted"]
for case let .some(datum) in data {
    print(datum)
}
for case let datum? in data {
    print(datum)
}

print("******************************************************************** Matching Enums and associated Values ********************************************************************")


enum WeatherType {
    case cloudy(coverage: Int)
    case sunny
    case windy
}

let today = WeatherType.cloudy(coverage: 100)

switch today {
case .cloudy(let coverage) where coverage == 0:
    print("You must live in Death Valley")
case .cloudy(let coverage) where (1...50).contains(coverage):
    print("It's a bit cloudy, with \(coverage)% coverage")
case .cloudy(let coverage) where (51...99).contains(coverage):
    print("It's very cloudy, with \(coverage)% coverage")
case .cloudy(let coverage) where coverage == 100:
    print("You must live in the UK")
case .windy:
    print("It's windy")
default:
    print("It's sunny")
}

// And for usage in Loop: 
let forecast: [WeatherType] = [.cloudy(coverage:40), .sunny, .windy, .cloudy(coverage: 100), .sunny]
for case let .cloudy(coverage) in forecast {
    print("It's cloudy with \(coverage)% coverage")
}
//If you know the associated value and want to use it as a filter, the syntax is almost the same:
let forecast2: [WeatherType] = [.cloudy(coverage: 40), .sunny, .windy, .cloudy(coverage: 100), .sunny]

for case .cloudy(40) in forecast2 {
    print("It's cloudy with 40% coverage")
}

print("******************************************************************** Matching Types ********************************************************************")
// Keyword is can be used fo matching: 
    
let view: AnyObject = UIButton()
    
    switch view {
    case is UIButton:
        print("Found a button")
    case is UILabel:
        print("Found a label")
    case is UISwitch:
        print("Found a switch")
    case is UIView:
        print("Found a view")
    default:
        print("Found something else")
    }

// Swift will take the first matching case it finds, and is returns true if an object is a specific type or one of its parent classes. So, the above code will print "Found a button", but button is also a View, so it will rely in the order of case senteces 

//a more useful example, you can use this approach to loop over all subviews in an array and filter for labels:

//for label in view.subviews where label is UILabel {
  //      print("Found a label with frame \(label.frame)")
//}

print("******************************************************************** Using the where keywords ********************************************************************")

let celebrities: [String?] = ["Michael Jackson", nil, "Michael Caine", nil, "Michael Jordan"]

for name in celebrities where name != nil {
    print(name)
}

for case let name? in celebrities {
    print(name)
}


// it works but prints optionals one approach is to ! unwrap optional or:

print("******************************************************************** Nil Coalesce ********************************************************************")

//let name: String? = nil
//
//let unwrappedName = name ?? "Nil"
//
//print(unwrappedName)
//
//print (name ?? 1)
//
//
//do {
//    let savedText = try String(contentsOfFile: "saved.txt")
//    print(savedText)
//} catch {
//    print("Failed to load saved text.")
//}
//
//
//let savedText: String
//do {
//    savedText = try String(contentsOfFile: "saved.txt")
//} catch {
//    print("Failed to load saved text.")
//    savedText = "Hello, fucking world!"
//}
//print(savedText)
//
//
let savedText2 = (try? String(contentsOfFile: "saved.txt")) ?? "Is nil"
print (savedText2 )


//// ******************************************************************** Guard ********************************************************************/////

//func giveAward(to name: String?) {
//    guard let winner = name else {
//        print("No one won the award")
//        return
//    }
//    
//    guard winner == "Taylor Swift" || winner == "Javier Jara"   else {
//        print("No way!")
//        return
//    }
//    
//    print("Congratulations, \(winner)!")
//}
//
//giveAward(to: "Taylor Swift")
//giveAward(to: "Javier Jara")
//giveAward(to: nil)


//// ******************************************************************** Lazy Var ********************************************************************///

//struct Homer {
//
//    lazy var donustPerDay = 15
//    
//    lazy var beersPerDay: Int = self.getBeersPerday()
//
//    private func getBeersPerday() -> Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        let dayOfWeek = dateFormatter.string(from:Date())
//        
//        if dayOfWeek == "Thursday" || dayOfWeek == "Sunday" {
//            return 30
//        } else {
//            return 17
//        }
//    }
//}
//
//var homer = Homer()
//
//homer.beersPerDay
//homer.donustPerDay

//// ******************************************************************** Singletons ********************************************************************///

//class MusicPlayer {
//    var musicQuality : Int
//    
//    init(quality: Int = 0) {
//        print("Ready to play songs!")
//        self.musicQuality = quality
//    }
//    
//}
//
//class Singer {
//    
//    init() {
//        print("Creating a new singer")
//    }
//    static let musicPlayer = MusicPlayer(quality:10)
//
//}
//

//let taylor = Singer()
//Singer.musicPlayer
//
//

//// ******************************************************************** Sequence Singletons ********************************************************************///

//func fibonacci(of num: Int) -> Int {
//    if num < 2 {
//        return num
//    } else {
//        return fibonacci(of: num - 1) + fibonacci(of: num - 2)
//    }
//}
//
//let fibonacciSequence = Array(0...200).lazy.map(fibonacci)
//
//print(fibonacciSequence[19])
//
//print(fibonacciSequence[19])
//
//print(fibonacciSequence[19])

//// ******************************************************************** Destructuring ********************************************************************///

//let data = ("one", "two", "three")
//
//let (one, two, three) = data
//
//// here you ignore the third value
//let (one1, two2, _) = data
//
//
//// For swapping two variables, without using a third one:
//var A = 8
//var B = 9
//
//print("A is: \(A), and B is: \(B)")
//(A, B) = (B, A)
//
//print("A is now: \(A), and B is now: \(B)")

//// ******************************************************************** Labeled Statements ********************************************************************///

// one can label any statement (ie if, while, for)

//var board = [[String]](repeating: [String](repeating: "",count: 10), count: 5)
//board[3][5] = "x"
//rowLoop: for (rowIndex, cols) in board.enumerated() {
//    colLoop: for (colIndex, col) in cols.enumerated() {
//        if col == "x" {
//            print("Found the treasure at row \(rowIndex) col \(colIndex)!")
//            break rowLoop
//        }
//    }
//}


//// ******************************************************************** Nested Functions ********************************************************************///

struct Point {
    let x: Double
    let y: Double
}
enum DistanceTechnique {
    case euclidean
    case euclideanSquared
    case manhattan
}

/** 
- Returns: Double formated 0.0
- Parameter start: is a Point Struct
- Parameter end: is a Point Struct either
- Parameter technique: enum motherfucker
- Authors: Javier Jara
 - Precondition: end must be higher than (0,0)
 - Throws: LoadError.networkFailed, LoadError.writeFailed
 - Complexity: O(1)
 */
func calculateDistance(start: Point, end: Point, technique: DistanceTechnique) -> Double {
    func calculateEuclideanDistanceSquared() -> Double {
        let deltaX = start.x - end.x
        let deltaY = start.y - end.y
        return deltaX * deltaX + deltaY * deltaY
    }
    func calculateEuclideanDistance() -> Double {
        return sqrt(calculateEuclideanDistanceSquared())
    }
    func calculateManhattanDistance() -> Double {
        return abs(start.x - end.x) + abs(start.y - end.y)
    }
    switch technique {
    case .euclidean:
        return calculateEuclideanDistance()
    case .euclideanSquared:
        return calculateEuclideanDistanceSquared()
    case .manhattan:
        return calculateManhattanDistance()
    }
}

let distance = calculateDistance(start: Point(x: 10, y: 10), end: Point(x: 100, y: 100), technique: .euclidean)

//// ******************************************************************** Documentation markup ********************************************************************///

