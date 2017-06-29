// Chapter 6
// Functional Programming

//  There are Five Functional Principles regarding writing funcitons and they are: 
//1) first-class data types,
//2) higher-order functions,
//3) pure functions,
//4) immutability, and
//5) reduce state.


print("*************************** map ********************** ")

// the first example is Map, the example takes an array of strings and returns an array with string lenght, commonly written as: 

func lengthOfFull(strings: [String]) -> [Int] {
    var result = [Int]()
    for string in strings {
        result.append(string.characters.count)
    }
    return result
}

// But by using map as functional mehod is:

func lengthOf(strings: [String]) -> [Int] {
    return strings.map { $0.characters.count }
}

// examples

let scores = [100, 80, 85]
let passOrFail = scores.map { $0 > 85 ? "Pass" : "Fail" }
print(passOrFail)


let position = [50, 60, 40]

// checks that each position is within a the range 45 to 55 inclusive:
let averageResults = position.map { 45...55 ~= $0  ? "Within average" : "Outside average" }
print(averageResults)

print("*************************** optional map ********************** ")

// The Map: "takes a value out of a container, applies a function to it, then puts the result of that function back into a new container that gets returned to you." We've been using an array so far, but if you think about it a value inside a container is exactly what optionals are. They are defined like this:
//enum Optional<Wrapped> {
//    case none
//    case some(Wrapped)
//}


import Foundation


// Since optional are containers for a single value we can use map on optionals: 

let i: Int? = 10

let j = i.map { $0 * 2 }

print(j)


func fetchUsername(id: Int) -> String? {
    if id == 1989 {
        return "Taylor Swift"
    } else{
        return nil }
}

//That returns an optional string, so we'll either get back "Taylor Swift" or nil. If we wanted to print out a welcome message – but only if we got back a username – then optional map is perfect:

var username: String? = fetchUsername(id: 1989)
let formattedUsername = username.map { "Welcome, \($0)!" } ?? "Unknown user"


print(formattedUsername)



print("*************************** forEach ********************** ")

// The difference between for each and map is that the seconds returns a new array whereas forEach returns noting, just iterates over the array

//Other than the return value, forEach() is used the same as map(): 

["Taylor", "Paul", "Adele"].forEach { print($0) }

// Another difference is execution order: forEach() is guaranteed to go through an array’s elements in its sequence, whereas map() is free to go in any order it pleases.

print("*************************** flatMap() ********************** ")

// When working with an array of arrays you get access to the joined fx that converts all in one single array: 

let numbers = [[1,2],[2,4],[3,5]]

let joined = Array(numbers.joined())

// flat map is the combination of using map() and joined() in one singlecall. 

// This becomes valuable when you remember that arrays and optionals are both containers, so flatMap()'s ability to remove one level of containment is very welcome indeed.

let albums: [String?] = ["Fearless", nil, "Speak Now", nil , "Red"]
let resultMap = albums.map { $0 }
let resultFlatMap = albums.flatMap { $0 }
// Mapping using $0 just means "return the existing value," so that code will print the following:
print(resultMap)
// Maggically flatmap will strip out optionals and removed nils ! yay
print(resultFlatMap)

// So imagine we need to convert Int Strings into Int, but could have an invalid output, so here helps flatmap: 

let scoresFlat = ["100", "90", "Fish", "85"]
let flatMapScores = scoresFlat.flatMap { Int($0) }
print(flatMapScores)

let scoresArray = [["100", "90", "Fish", "85"], ["89", "60", "Fish", "122"], ["100", "100", "12eh", "99"]]
let allScores = Array(scoresArray.joined())
let flapMapSA = allScores.flatMap { Int($0) }
print(flapMapSA)

// How to use flatmap example: 

let files = (1...10).flatMap { try? String(contentsOfFile: "someFile-\($0).txt") }
print(files)


// that don't exist will throw an exception, which try? converts into nil, and flatMap() will ignore – all with just one line of code!

//let labels = view.subviews.flatMap { $0 as? UILabel }
//
//That will attempt to typecast each subview as a UILabel, and place any items that succeeded into the returning array. Even better, Swift is smart enough to infer that labels should be of type [UILabel].

print("*************************** filter() ********************** ")

//The filter() method loops over every item in a collection, and passes it into a function that you write. If your function returns true for that item it will be included in a new array, which is the return value for filter()

let names = ["Javier Jara", "Laura Vargas", "Ricardo Chinchilla", "Esteban Duran"]

let javiers = names.filter{ $0.contains("Javier")}

print(javiers.first ?? "No Javier in list")


//Finally, filter() behaves curiously when presented with a dictionary: you get back an array of tuples containing the result, rather than another dictionary. So, you should access items using array subscripting to get an item, then .0 and .1 for the key and value respectively. For example:

let scoresDict = ["Paul": 100, "Taylor": 95, "Adele": 90, "Michael": 85, "Justin": 60]

let goodScores = scoresDict.filter { $1 > 85 }

print(goodScores[0].0)

print("*************************** reduce() ********************** ")

let sum = scores.reduce(0, +)

// try to use it to sum the number of characters used in all the names below:

let names1 = ["Taylor", "Paul", "Adele"]
// your code here
let count = names1.reduce(0) {$0 + $1.characters.count}
print(count)

// Reducing to a Boolean

// this will evaluate all names are > 4
let longEnough = names1.reduce(true) { $0 && $1.characters.count > 4}
print(longEnough)

// That function starts with an initial value of true, then uses && to compare the existing value against a new one.

// There's an obvious but unavoidable problem here, which is that if we're checking 1000 items and item 2 fails the test, we don't need to continue. -> here in a loop you can use break 

// reduce can be used to join multi direccional arrays: 

let numbers2 = [
    [1, 1, 2],
    [3, 5, 8],
    [13, 21, 34] ]

let flattened: [Int] = numbers2.reduce([]) { $0 + $1 }

print(flattened)

print("*************************** sort() ********************** ")


let scoresString = ["100", "95", "85", "90", "100"]
let scoresInt = scoresString.flatMap { Int($0) }
let sortedInt = scoresInt.sorted()
print(sortedInt)

// This is another way to see the diff between flat map and map, since map return optional, then the sort will look like:

//let scoresInt = scoresString.map { Int($0) }
//let sortedInt = scoresInt.sorted {
//    if let unwrappedFirst = $0, let unwrappedSecond = $1 {
//        return unwrappedFirst < unwrappedSecond
//    } else {
//        return false
//    } }


// Sorting complex data 

struct Person {
    var name: String
    var age: Int
}

let taylor = Person(name: "Taylor", age: 26)
let paul = Person(name: "Paul", age: 36)
let justin = Person(name: "Justin", age: 22)
let adele = Person(name: "Adele", age: 27)
let people = [taylor, paul, justin, adele]

//Because people doesn't store primitive data types, there's no parameter-less sorted() method. So, the first way to sort the people array is simply by writing a custom closure for the sorted() method, like this:

let sortedPeople = people.sorted { $0.name < $1.name }

// The smarter solution is to conforms the comparable protrocol, since you could use this more than once so: 


struct PersonComparable: Comparable {
    var name: String
    var age: Int
    
    // In order to implement comparable, you need to add 2 functions: < and ==. These allow us to compare and sort items, so this is where you'll add your sorting logic 
    
    static func < (lhs: PersonComparable, rhs: PersonComparable) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: PersonComparable, rhs: PersonComparable) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}

let taylorC = PersonComparable(name: "Taylor", age: 26)
let paulC = PersonComparable(name: "Paul", age: 36)
let justinC = PersonComparable(name: "Justin", age: 22)
let adeleC = PersonComparable(name: "Adele", age: 27)
let peopleC = [taylorC, paulC, justinC, adeleC]

let sortedPeopleC = peopleC.sorted()

// Reverse Sorting 

//let sortedArray = Array(names.sorted().reversed())
//print(sortedArray)


print("*************************** Function Composition ********************** ")


// Building chaining functions can be donde with operator overloading: 

// let foo = functionA >>> functionB >>> functionC

precedencegroup CompositionPrecedence {
    associativity: left
}

infix operator >>>: CompositionPrecedence

func >>> <T, U, V>(lhs: @escaping (T) -> U, rhs: @escaping (U)-> V) -> (T) -> V {
    return { rhs(lhs($0))}
}

// Both functions must be declared @escaping because we’re creating and returning a new closure that will call them later.
// Consider this example: 

func generateRandomNumber(max: Int) -> Int {
    let number = Int(arc4random_uniform(UInt32(max)))
    print("Using number: \(number)")
    return number
}
func calculateFactors(number: Int) -> [Int] {
    return (1...number).filter { number % $0 == 0 }
}
func reduceToString(numbers: [Int]) -> String {
    return numbers.reduce("Factors: ") { $0 + String($1) + " " }
}

//When called in a sequence, that will generate a random number, calculate its factors, then convert that factor array into a single string. To call that in code you would normally write this:
//That needs to be read from right to left: generateRandomNumber() is called first, then its return value is passed to calculateFactors(), then its return value is passed to reduceToString(). And if you need to write this code more than once, you need to make sure you keep the order correct even when making changes in the future.
//Using our new compose operator, there's a better solution: we can create a new function that combines all three of those, then re-use that function however we need. For example:

let result = reduceToString(numbers: calculateFactors(number:generateRandomNumber(max: 100)))

print(result)


// BY USING the new composition you can create a new function an then call that function anytime
let combined = generateRandomNumber >>> calculateFactors >>> reduceToString

print(combined(100))

print("*************************** Lazy Functions ********************** ")


