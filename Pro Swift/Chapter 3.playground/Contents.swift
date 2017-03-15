import UIKit


//Next time you get a crash, follow these instructions to get right to the problem: click on the objc_exception_throw in your thread,
//then type "po $arg1" into the debug area to get the human-readable version of the error. If you use exception breakpoints,
//you can even add the "po $arg1" command there so it’s automatic.

// Types vs Value Types 

class Person {
    var target = Target(location:"")
}

struct Target
{
    var location:String
}

//struct Target {
//    var location = ""
//}

var luke = Person()
var wedge = Person()


// create a target
var target = Target(location:"")
// set its location to be the Death Star
target.location = "Death Star"
// tell Luke to attack the Death Star
luke.target = target
// oh no – Wedge is hit! We need to
// tell him to fly home
target.location = "Rebel Base"
wedge.target = target
// report back to base
print(luke.target.location)

print(wedge.target.location)

// There is a huge diference between using a struct (value type) vs a class (reference type)
// if we use a struct for Target, the location value will be different, since object is assigned as a copy. 
// otherwise a class is passed by reference, so any info will be modified 

print ("********************************************************************** Closures are references **********************************************************************")

//If you use closures infrequently this is not likely to be a problem, 
//and if you aren't using them to capture values then you're safe. 
//Otherwise, step carefully: working with reference types can be hard enough without also introducing closure capturing.

print ("********************************************************************** Why use structs **********************************************************************")
// Race Conditions: not happen on structs
// Thread Safe
// One last reason for preferring structs rather than classes: they come with memberwise initialization. This means the compiler automatically produces an initializer that provides default values for each of the struct's properties. For example:

struct Student {
    var name: String
    var age: Int
    var favoriteIceCream: String
}

let taylor = Student(name: "Taylor Swift", age: 26, favoriteIceCream: "Chocolate")

print ("********************************************************************** Why use Classes **********************************************************************")

// First Create a single object and share through everywhere, for example DB Connections 

// Is faster since no copies are made. 

// Inheritance: (not present in Structs) 


class StudentClass {
    // If decided to use class instead Struct, first the class properties must be initiaziled by default value:
//    var name: String = ""
//    var age: Int = 0
//    var favoriteIceCream: String = ""

    // Or declared and initialized by class initializator
    var name: String
    var age: Int
    var favoriteIceCream: String

    
    init(name: String, age: Int, favoriteIceCream:String){
        self.name = name
        self.age = age
        self.favoriteIceCream = favoriteIceCream
    }
}

let taylorClass = StudentClass(name: "Taylor Swift", age: 26, favoriteIceCream: "Chocolate")


print ("********************************************************************** Mixing Classes and Structs **********************************************************************")

// Use Boxing for converting Structs into Reference Types: 

final class StudentBox {
    var student: Student
    init(student: Student) {
        self.student = student
    }
}

let box = StudentBox(student: taylor)

final class TestContainer {
    var box: StudentBox!
}

let container1 = TestContainer()
let container2 = TestContainer()
container1.box = box
container2.box = box


print(container1.box.student.name)
print(container2.box.student.name)
box.student.name = "Not Taylor"
print(container1.box.student.name)
print(container2.box.student.name)

print ("********************************************************************** Immutability **********************************************************************")



