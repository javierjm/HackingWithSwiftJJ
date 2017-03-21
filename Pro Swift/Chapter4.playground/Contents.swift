//: Playground - noun: a place where people can play

import UIKit

print("************************** Variadic Functions **************************")

func add(numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
add(numbers: 1, 2, 3, 4, 5)

print("************************** Operator Overloading **************************")

// Swift sets Precedence and Associativity Operators by default to minimum 


// For changing precedence or associatviy is necessary to create groups, then assign it to operator like this: 

precedencegroup AdditionPrecedence {
    associativity: right // This sentence will execute the right operations firts
    higherThan: RangeFormationPrecedence // Se below commeted the default list from standard swift library
}

infix operator - : AdditionPrecedence

let i = 10 - 5 - 1


//precedencegroup AdditionPrecedence {
//    associativity: left
//    higherThan: RangeFormationPrecedence
//}
//precedencegroup MultiplicationPrecedence {
//    associativity: left
//    higherThan: AdditionPrecedence
//}
//infix operator * : MultiplicationPrecedence
//infix operator + : AdditionPrecedence
//infix operator - : AdditionPrecedence

print("************************** Addding to an existing operator **************************")

// For example: we want to multiply 2 arrays of Ints: let result = [1, 2, 3] * [1, 2, 3]

func *(lhs: [Int], rhs: [Int]) -> [Int] {
    guard lhs.count == rhs.count else { return lhs }
    var result = [Int]()
    for (index, int) in lhs.enumerated() {
        result.append(int * rhs[index])
    }
    return result
}

let result = [1, 2, 3] * [1, 2, 3]

print("************************** Creating new operator **************************")

// Step 1: you need to specify the new operator's position (prefix, postfix, or infix)
// Step 2:  if you don't specify a precedence or associativity Swift will provide default values that make it a low- priority, non-associative operator.

import Foundation // for using pow function 

// We set the associtativy and precedence In order to allow this to work: let result = 4 ** 3 ** 2

precedencegroup ExponentiationPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}
infix operator **  : ExponentiationPrecedence// the goal is to use this operator to pow a number

func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

// will accept any number, but used Double for flexibility 

let res = 2 ** 4

let powResult = pow(2, 4)


print("************************** Modifying existing operator **************************")

// in order to allow the range1 to work, must set associativy to the new operator so will perform left thigns first

infix operator ... : RangeFormationPrecedence1

precedencegroup RangeFormationPrecedence1 {
    associativity: left
    higherThan: CastingPrecedence
}

// End of range1 mods, just added this line:
//     associativity: left

func ...(lhs: CountableClosedRange<Int>, rhs: Int) -> [Int] {
    let downwards = (rhs ..< lhs.upperBound).reversed()
    return Array(lhs) + downwards
}

// this will not work, until associativy is declaree :
// let range1 = 1...10...1
// see this:

let range = (1...10)...1
let rangeAfterAssoc = 1...10...1
print(rangeAfterAssoc)


print("************************** closures **************************")


let greetPerson = { (name: String) in
    print("Hello, \(name)!")
}

// Example of a fucntion that accept a closuer with one parameter:
func runSomeClosure(_ closure: (String) -> Void) {
    closure("Taylor")
}

runSomeClosure(greetPerson)


let names = ["Michael Jackson", "Taylor Swift", "Michael Caine", "Adele Adkins", "Michael Jordan"]

// Full syntax clousure

let result1 = names.filter({ (name: String) -> Bool in
    if name.hasPrefix("Michael") {
        return true
    } else {
        return false;
    }
})

print(result1.count)

// Short hand closure (the same definition as above but shorter


let result6 = names.filter { name in
    name.hasPrefix("Michael")
}

let result7 = names.filter {
    $0.hasPrefix("Michael")
}

print("************************** function as a closure **************************")

// Example 1 

//The brilliant design of Swift's compiler lets us put these two things together: even though the string’s contains() is a Foundation method that comes from NSString, we can pass it into the array’s contains(where:) in place of a closure. So, the entire code becomes this

let words = ["1989", "Fearless", "Red"]
let input = "My favorite album is Fearless"
words.contains(where: input.contains)

// Example 2

let numbers = [1, 3, 5, 7, 9]

let resultNumber = numbers.reduce(0) { (int1, int2) -> Int in
    return int1 + int2
}

// Swift allows a second parameter that is a closure +
let resultNumberShort = numbers.reduce(0, +)

print("************************** Escaping cloruses **************************")

// When you pass a closure into a function, Swift considers it non-escaping by default. This means that the closure must be used immediately inside the function, and cannot be stored away for later

var queuedClosures: [() -> Void] = []

// Original implementation: 

//func queueClosure(_ closure: () -> Void) {
//    queuedClosures.append(closure)
//}

//Because the closures can be called later, Swift considers them to be escaping closures, and so it will refuse to build this code. Remember, non-escaping closures are the default for performance reasons, so we need to explicitly add the @escaping keyword to make our intention clear:

func queueClosure(_ closure: @escaping () -> Void) {
    queuedClosures.append(closure)
}

queueClosure({ print("Running closure 1") })
queueClosure({ print("Running closure 2") })
queueClosure({ print("Running closure 3") })

func executeQueuedClosures() {
    for closure in queuedClosures {
        closure() }
}
executeQueuedClosures()

print("************************** Autoclosures **************************")

// The attribute makes any call a closure, for example: 


func printTest(_ result: @autoclosure () -> Void) {
    print("Before")
    result()
    print("After")
}

printTest(print("Hello"))

// without the @autoclosure attribute the call must be: 
// printTest({print("Hello")})


print("************************** The ~= operator **************************")

// It's the pattern match operator 

// you can use contains():
let test1 = (1...100).contains(42)
// but using this operatorn the pair of parenthesis are ommited
let test2 = 1...100 ~= 42

