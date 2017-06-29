//: Playground - noun: a place where people can play

// Patters 
import Foundation

print("*************************** OOP ********************** ")


//you can tell Swift that only certain parts of your code can read or write properties or call methods. There are four access modifiers you can use:

//• private means "this can only be used by code in the same class or struct.”
//• fileprivate means “this can only be used by code in the same Swift file.”
//• internal means "this can only be used by code in my module", which is usually
//your app.
//• public means "anyone can use this."

print("*************************** POP ********************** ")
// POP stands for Protocol Oriented Programming 

//A protocol is a promise of functionality: the compiler will ensure that anyone who wants to conform to the protocol must implement all the methods you specify

// An extension is applied to all integers:
extension Int {
    func squared() -> Int {
        return self * self
    }
}

// A protocol extension is applied to all numbers that conforms the Integer Protocol, so you can square a UInt for example
extension Integer {
    func squared() -> Self {
        return self * self
    }
}

// Note that squared() returns Self with a capital S: this means "return whatever data type I'm being used with."

// After adding the protocol extension you can do this: 

let number: UInt = 5
let result = number.squared()


// POP Example:  I'm going to define six protocols with accompanying extensions. To keep things simple, I'm only going to give each protocol a single method

protocol Payable {
    func calculateWages() -> Int
}
extension Payable {
    func calculateWages() -> Int {
        return 10000
    }
}
protocol ProvidesTreatment {
    func treat(name: String)
}
extension ProvidesTreatment {
    func treat(name: String) {
        print("I have treated \(name)")
    }
}
protocol ProvidesDiagnosis {
    func diagnose() -> String
}
extension ProvidesDiagnosis {
    func diagnose() -> String {
        return "He's dead, Jim"
    }
}

protocol ConductsSurgery {
    func performSurgery()
}
extension ConductsSurgery {
    func performSurgery() {
        print("Success!")
    }
}
protocol HasRestTime {
    func takeBreak()
}
extension HasRestTime {
    func takeBreak() {
        print("Time to watch TV")
    }
}
protocol NeedsTraining {
    func study()
}
extension NeedsTraining {
    func study() {
        print("I'm reading a book")
    }
}

// We're going to define four roles: receptionist, nurse, doctor, and surgeon

// And with protocols in place let's create 4 structs 

struct Receptionist { }
struct Nurse { }
struct Doctor { }
struct Surgeon { }


// Now it's time to select wich roles will have each struct, for example our structs will be able to:

// extension Receptionist: Payable, HasRestTime, NeedsTraining {}
// extension Nurse: Payable, HasRestTime, NeedsTraining, ProvidesTreatment {}
// extension Doctor: Payable, HasRestTime, NeedsTraining, ProvidesTreatment, ProvidesDiagnosis {}
// extension Surgeon: Payable, HasRestTime, NeedsTraining, ProvidesDiagnosis, ConductsSurgery {}


// Notice how there are duplicate definitions, we can avoid that by grouping in one single Protocol:


protocol Employee: Payable, HasRestTime, NeedsTraining {}

// Then the extension implementation will be:
extension Receptionist: Employee {}
extension Nurse: Employee, ProvidesTreatment {}
extension Doctor: Employee, ProvidesDiagnosis, ProvidesTreatment {}
extension Surgeon: Employee, ProvidesDiagnosis, ConductsSurgery{}

print("******************************************** Constrained extensions ********************************************")

// What if we want to add funciontality to a group of protocl, but only for those who adopt certain behaviour ? : 

extension Employee where Self: ProvidesTreatment {
    func checkInsurance() {
        print("Yup, I'm totally insured")
    }
}


