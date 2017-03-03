// Chapter 3 

import UIKit

//********************************************************************** Usefull initializers ************************************************************************************//

let heading = "This is a heading"

// repeating, count for Strings and Arrays

let underline = String(repeating: "=", count: heading.characters.count)
let equalsArray = [String](repeating: "1", count: heading.characters.count)

var board = [[String]](repeating: [String](repeating: "",count: 12), count: 11)

print("Boar count is: \(board[0].count)")

//********************************************************************** Converting to and form numbers ************************************************************************************//

// Instead using this: 
// let str1 = "\(someInteger)"
// use this:
// let str2 = String(someInteger)

let int1 = Int("elephant") ?? 0
let int4 = Int("1C", radix: 16)

print("\(int4)")
//********************************************************************** Unique arrays ************************************************************************************//

// How to remove duplicates from arrays ?

let scores = [5, 3, 6, 1, 3, 5, 3, 9]
let scoresSet = Set(scores)
let uniqueScores = Array(scoresSet)

//********************************************************************** Enums ************************************************************************************//
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
    case unknown
}

print("Earth has a value of: \(Planet.earth.rawValue)")

let mars = Planet(rawValue: 556) ?? Planet.unknown

mars.rawValue

enum Color: String {
    case unknown, blue, green, pink, purple, red
    
    var description: String {
        switch self {
        case .unknown:
            return "The color of magic"
        case .blue:
            return "The color of the sky"
        case .green:
            return "The color of grass"
        case .pink:
            return "The color of carnations"
        case .purple:
            return "The color of rain"
        case .red:
            return "The color of desire"
        }
    }
    
    func capitalized()->String{
        return self.rawValue.capitalized
    }
}

struct Toy {
    let name: String
    let color: Color
}

let pink = Color.pink.rawValue
print(pink)

let barbie = Toy(name: "Barbie", color: .pink)
let raceCar = Toy(name: "Lightning McQueen", color: .red)

// regular string interpolation
print("The \(barbie.name) toy is color: \(barbie.color.capitalized()), \(barbie.color.description)")
// get the string form of the Color then call a method on it
print("The \(barbie.name) toy is \(barbie.color.rawValue.uppercased())")

//********************************************************************** Arrays ************************************************************************************//


// Protocol Comparable is required if you want to use sort, min, max functions in array, elements inside array must adopt the protocol 


struct Dog: Comparable, Hashable {
    var breed: String
    var age: Int
    
    static func <(lhs: Dog, rhs: Dog) -> Bool {
        return lhs.age < rhs.age
    }
    static func ==(lhs: Dog, rhs: Dog) -> Bool {
        return lhs.age == rhs.age
    }
    
    var hashValue: Int {
        return age
    }
}


let poppy = Dog(breed: "Poodle", age: 2)
let rusty = Dog(breed: "Labrador", age: 2)
let rusty1 = Dog(breed: "Labrador", age: 2)
let rover = Dog(breed: "Corgi", age: 11)
var dogs = [poppy, rusty, rover]

dogs.sort()


let beethoven = Dog(breed: "St Bernard", age: 8)

//// How to add elements to an array, alternavite to insert, append.
dogs += [beethoven]

let dogRemoved = dogs.removeLast()

dogRemoved.breed
dogs.count
dogs.removeLast()
dogs.removeLast()
dogs.removeLast()

// OJO: removeLast() will crash if array is empty, whereas popLast will return an optional, so type checking will be necessary

if let dog = dogs.popLast() {
    print("Removed dog: \(dog.breed)")
} else {
    print("array is empty, asshole")
}

// Check if array is EMPTY, more efficient that comparing count == 0 
if dogs.isEmpty {
    print("array is empty, asshole")
}

// Look for reserveCapacity() this will reserve contiguos spaces for an array 

//********************************************************************** Sets ************************************************************************************//

var set1 = Set<Int>([1, 2, 3, 4, 5])
var dogsSet = Set<Dog>([poppy, rusty, rover, beethoven])

if dogsSet.contains(poppy) {
    print("found \(poppy.breed)")
} else {
    print("Not found \(poppy.breed)")
}

dogsSet.removeFirst()
dogsSet.popFirst()
dogsSet.removeFirst()
dogsSet.popFirst()
dogsSet.popFirst()


// USE union to merge 2 sets: let union = set1.union(set2) 
// Use intersection" let intersection = spaceships1.intersection(spaceships2)
// Use difference let difference = spaceships1.symmetricDifference(spaceships2)

// Other methods 

    
//• A.isSubset(of: B): returns true if all of set A's items are also in set B.
//• A.isSuperset(of: B): returns true if all of set B's items are also in set A.
//• A.isDisjoint(with: B): returns true if none of set B's items are also in set A.
//• A.isStrictSubset(of: B): returns true if all of set A's items are also in set B,
//      but A and B are not equal
//• A.isStrictSuperset(of: B): returns true if all of set B's items are also in set
//      A, but A and B are not equal


// 