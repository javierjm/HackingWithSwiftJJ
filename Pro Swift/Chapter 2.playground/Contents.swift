// Chapter 2

import UIKit

print("********************************************************************* Usefull initializers ***********************************************************************************")

let heading = "This is a heading"

// repeating, count for Strings and Arrays

let underline = String(repeating: "=", count: heading.characters.count)
let equalsArray = [String](repeating: "1", count: heading.characters.count)

var board = [[String]](repeating: [String](repeating: "",count: 12), count: 11)

print("Boar count is: \(board[0].count)")

print("********************************************************************* Converting to and form numbers ***********************************************************************************")

// Instead using this: 
let str1 = "\(666)"
// use this:
let str2 = String(666)

let int1 = Int("elephant") ?? 0
let int4 = Int("1C", radix: 16)

print("\(int4)")


print("********************************************************************* Unique arrays ***********************************************************************************")


// How to remove duplicates from arrays ?

let scores = [5, 3, 6, 1, 3, 5, 3, 9]
let scoresSet = Set(scores)
let uniqueScores = Array(scoresSet).sorted()

print("********************************************************************* Enums ***********************************************************************************")
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


// just specifying String as the raw data type for your enum is enough to give them meaningful names – Swift automatically maps your enum name to a string. For example, this will print "Pink":

let pink = Color.pink.rawValue
print(pink)

let barbie = Toy(name: "Barbie", color: .pink)
let raceCar = Toy(name: "Lightning McQueen", color: .red)

// regular string interpolation
print("The \(barbie.name) toy is color: \(barbie.color.capitalized()), \(barbie.color.description)")
// get the string form of the Color then call a method on it
print("The \(barbie.name) toy is \(barbie.color.rawValue.uppercased())")

print("********************************************************************* Arrays ***********************************************************************************")


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

print("********************************************************************* Sets ***********************************************************************************")

var set1 = Set<Int>([1, 2, 3, 4, 5])
var dogsSet = Set<Dog>([poppy, rusty, rover, beethoven])
// That creates a new set from an array, but you can create them from ranges too, just like arrays:
var set2 = Set(1...100)

// You can also add items to them individually, although the method is named insert() rather than append() to reflect its unordered nature:
set1.insert(6)
set1.insert(7)


// To check whether an item exists in your set, use the lightning fast contains() method:

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

print("********************************************************************* Tuples ***********************************************************************************")

// Important review pattern Matching and destructuring 

var thisIsAllowed = (value: 42)
var thisIsNot: Int = (23)
var thisIsNot1: (Int) = 25

var singer = ("Taylor", 14)
singer = ("Taylor", 23)

// to access the touple you just have to use the name.position of element: 
print(singer.0)

// You can name elements of touple for easy access
var singerNamedTouple = (name: "Taylor", age: 14)
print(singerNamedTouple.name)

// Optional Tuples, tuples can be optional (the whole tuple), or some elements could be optional as well. 

// Comparig Tuples: 2 tuples can be compared if contains up to 6 elements using ==, notice that comparisong will ignore labels, so will focus on types only: 

var cyclist1 = ("Javier", "Jara", "Master A", "Rocos Brujos", "Canondale", "XL")
var cyclist2 = (fistname: "Javier", lastname:"Jara", category:"Master A", team:"Rocos Brujos", bike:"Canondale", frameSize:"XL")
var cyclist3 = (fistname: "Laura", lastname:"Vargas", category:"Master Fem", team:"Rocos Brujos", bike:"Giant", frameSize:"XS")

if cyclist3 == cyclist2 {
    print("same cyclist")
} else {
    print("different cyclist")
}

// Type Alias 

typealias Name = (first: String, last: String)

func marryTaylorsParents(man: Name, woman: Name) -> (husband:Name, wife: Name) {
        return (man, (woman.first, man.last))
}

let father = (first: "Scott", last: "Swift")
let mother = (first: "Andrea", last: "Finlay")

let marry = marryTaylorsParents(man: father, woman: mother)

marry.0.1
marry.wife.last

print("********************************************************************** Genercis *********************************************************************************")

// Example 

func inspect<T>(_ value: T) {
    print("Received \(type(of: value)) with the value \(value)")
}

inspect("Haters gonna hate")
inspect(56)

// Using a Generic struct 

struct deque<T> {
    var array = [T]()
    mutating func pushBack(_ obj: T) {
        array.append(obj)
    }
    mutating func pushFront(_ obj: T) {
        array.insert(obj, at: 0)
    }
    
    mutating func popBack() -> T? {
        return array.popLast()
    }
    mutating func popFront() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
}

var testDeque = deque<Int>()
testDeque.pushBack(5)
testDeque.pushFront(2)
testDeque.pushFront(1)
testDeque.popBack()


// Cocoa data Types
// these data types for example (NSDictionary, NSArray, and in this Case NSCountedSet() does not support generics here an example for adding support through a struct 


import Foundation

struct CustomCountedSet<T> {

    let internalSet = NSCountedSet()
    
    mutating func add(_ obj: T) {
        internalSet.add(obj)
    }
    mutating func remove(_ obj: T) {
        internalSet.remove(obj)
    }
    func count(for obj: T) -> Int {
        return internalSet.count(for: obj)
    }
}

var countedSet = CustomCountedSet<String>()
countedSet.add("Hello")
countedSet.add("Hello")
countedSet.count(for: "Hello")
var countedSet2 = CustomCountedSet<Int>()
countedSet2.add(5)
countedSet2.count(for: 5)
