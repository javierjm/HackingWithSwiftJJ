//: Playground - noun: a place where people can play

import UIKit

//// ******************************************************************** Nil Coalesce ********************************************************************///

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
//let savedText2 = (try? String(contentsOfFile: "saved.txt"))
//print (savedText2 ?? "Is Fucking nil")


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

