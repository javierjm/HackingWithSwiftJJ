//: Playground - noun: a place where people can play
import Foundation

print("****************************** Example Extensions ******************************")

print("Example #1 - Squaring Integers")

extension Int {
    func squared() ->Int {
        return self * self
    }
}

// Again this will work only for Ints, if you want to extend to UInt, so you will need to use:
extension Integer {
    func squared() -> Self {
        return self * self
    }
}

// Notice the Self with a capital S – it means “whatever data type we’re being used with,” which is different to “self” with a lowercase s. So, Self means Int when working with that data type, or Int64 when working with that instead, whereas self (lowercase S!) means the actual number being stored.

print("Example #2 - Clamping Integers")
// create an extension for all integer types that returns the value clamped between two values
extension Integer {
    func clamped(low:Self, high:Self) -> Self {
        return min(max(self, low), high)
    }
}

print("Example #3 - Matching value types")
// create an extension for all integer types that returns the value clamped between two values

// We’re going to add an extension to Equatable so that one value can be checked against an array of values of the same type in one method. So, 2.matches(array: [2, 2, 2, 2]) will return true, but 2.matches(array: [2, 2, 2, 3]) will return false.
extension Equatable {
    func matches(array items:[Self]) -> Bool {
        return (items.filter{$0 != self}.count) == 0
    }
}

2.matches(array: [2, 2, 2, 3])
2.matches(array: [2, 2, 2, 2])

print("Example #4 - Comparing arrays")

extension Comparable{
    func lessThan(array items:[Self]) -> Bool {
        let result = items.filter{ $0 < self}
        return (result.count) == 0
    }
}

5.lessThan(array: [6, 7, 8])
5.lessThan(array: [6, 7, 9, 9, 8, 6])
"cat".lessThan(array: ["dog", "fish", "gorilla"])


print("Example #5 - Rewriting contains()")

// The method needs to loop over every item in an array until it finds one that matches – i.e., returns true for == - and input object. This means using the Equatable protocol again, which is what guarantees us support for ==.

// Is the same as Contains method, but written by us, since we are extending the Collection protocol, we must be sure to apply it to colletions that contains equtatable Elements, this is achieved by using Iterator.Element and were clause in extension definition:

extension Collection where Iterator.Element: Equatable {
    func myContains(element: Iterator.Element) -> Bool {
        for item in self {
            if item == element {
                return true }
        }
        return false
    }
}


print("Example #6 - Fuzzy array matching")


extension Collection where Iterator.Element: Comparable {
    func fuzzyMatches(_ items:Self) -> Bool {
        guard (self.count == items.count) else{
            return false
    }
        return self.sorted() == items.sorted()
    }
    
}

[1, 2, 3].fuzzyMatches([1, 2, 3, 6])


print("Example seven: average string length")


// Notice this line: 
// Iterator.Element == String 
//   is the not same as writing
// Iterator.Element : String
// The == means  items are a specific data type instead conforming a protocol

extension Collection where Iterator.Element == String {
    func averageLength() -> Double {
        var sum = 0
        var count = 0
        self.forEach {
            sum += $0.characters.count
            count += 1
        }
        return Double(sum) / Double(count)
    }
}


print("Example eight: counting integers")

// Create an extension that accepts an array of integers and returns how many times the digit 5 appears in any number.

extension Collection where Iterator.Element == Int {
    func howManyfives() -> Int {
        var fives = 0
        self.forEach{
            let str = String($0)
            let range = Range(uncheckedBounds: (lower: str.startIndex, upper: str.endIndex))
            String($0).enumerateSubstrings(in: range, options: .byWords) {(substring, _, _, _) -> () in
                fives = (substring?.contains("5"))! ? fives + 1 : fives
            }
        }
        
        return fives
    }
}

[5, 3, 5, 1, 5].howManyfives()
[0, 3, 6, 1, 3].howManyfives()

print("Example nine: De-duping an array")

// We already implemented our own myContains() method and in doing so learned that Equatable is what provides the == operator for a given data type. So, in this example we can require that our array holds elements that conform to Equatable, and in doing so we’ll automatically get the built-in contains() method.

extension Array where Element: Equatable {
    func uniqueValues() -> [Element] {
        var result = [Element]()
        for item in self {
            if !result.contains(item) {
                result.append(item)
            }
        }
        return result
    }
}

// There are two things to note there. First, we’re extending the Array type specifically, so there’s no more Iterator – it’s just a group of values. Second, I declared the result array to be of type [Element], which means it will match whatever the input array held.

print("Example ten: Array is sorted")

extension Array where Element: Comparable {
    
    func isSorted() -> Bool {
        return self == self.sorted()
    }
}



import Foundation

let word = "RHYTHM"
var usedLetters = [Character]()
print("Welcome to Hangman!")
print("Press a letter to guess, or Ctrl+D to quit.")

func printWord() {
    print("\nWord: ", terminator: "")
    var missingLetters = false
    for letter in word.characters {
        if usedLetters.contains(letter) {
            print(letter, terminator: "")
        } else {
            print("_", terminator: "")
            missingLetters = true
        }
    }
    print("\nGuesses: \(usedLetters.count)/8")
    if missingLetters == false {
        print("It looks like you live on... for now.")
        print("Thanks for playing!")
        exit(0)
    } else {
        if usedLetters.count == 8 {
            print("Oops – you died! The word was \(word).")
            print("Thanks for playing!")
            exit(0)
        } else {
            print("Enter a guess: ", terminator: "")
        }
    }
}

printWord()


while var input = readLine() {
    if let letter = input.uppercased().characters.first {
        if usedLetters.contains(letter) {
            print("You used that letter already!")
        } else {
            usedLetters.append(letter)
        } }
    printWord()
}
