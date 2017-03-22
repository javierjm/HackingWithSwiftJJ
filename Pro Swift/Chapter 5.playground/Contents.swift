import Foundation


print("************************************ Errors ******************************************************")


//Let's start off with a simple example. All errors you want to throw must be an enum that conforms to the Error protocol, which Swift can bridge to the NSError class from Objective-C. So, we define an error enum like this:

enum PasswordError: Error {
    case empty
    case short(minChars: Int)
    case obvious(message: String)
}

//To mark a function or method as having the potential to throw an error, add throws before its return type, like this:

//func encrypt(_ str: String, with password: String) throws ->String {
//        // complicated encryption goes here
//        let encrypted = password + str + password
//        return String(encrypted.characters.reversed())
//}

// Example with associated value for enum
func encrypt(_ str: String, with password: String) throws -> String {
        // complicated encryption goes here
        if password == "12345" {
            throw PasswordError.obvious(message: "I have the same number on my luggage")
        }
        let encrypted = password + str + password
    
        return String(encrypted.characters.reversed())
}



// For calling the function that throws it necessary to use do, try, catch mix: 

do {
    let encrypted = try encrypt("Secret!", with: "T4yl0r")
    print(encrypted)
} catch {
    print("Encryption failed")
}

// Handling all errors in a single catch block might work for you sometimes, but more often you'll want to catch individual cases. 

do {
    let encrypted = try encrypt("secret information!", with:
        "T4ylorSw1ft")
    print(encrypted)
} catch PasswordError.empty {
    print("You must provide a password.")
}
    //catch PasswordError.short {
//    print("Your password is too short.")
//} 
    //  When working with associated values you can also use pattern matching. To do this, first use let to bind the associated value to a local constant, then use a where clause to filter. For example,
catch PasswordError.short(let minChars) where minChars < 5 {
    print("We have a lax security policy: passwords must be at least \(minChars)")
} catch PasswordError.short(let minChars) where minChars < 8 {
    print("We have a moderate security policy: passwords must be at least \(minChars)")
} catch PasswordError.short(let minChars) {
    print("We have a serious security policy: passwords must be at least \(minChars)")
}
    
catch PasswordError.obvious (let message) {
   print("Your password is obvious: \(message)")
} catch {
    print("Error")
}

print("************************************ Throwing functions as parameters ******************************************************")


// Example a function that uses a non throwing function or a throwing as parameter, for example:

enum Failure: Error {
    case badNetwork(message: String)
    case broken
}

func fetchRemote() throws -> String {
    // complicated, failable work here
    throw Failure.badNetwork(message: "Firewall blocked port.")
}
func fetchLocal() -> String {
    // this won't throw
    return "Taylor"
}


// The third function is where things get interesting: it needs to call either fetchRemote() or fetchLocal() and do something with the data that was fetched. 


func fetchUserData(using closure: () throws -> String) {
    do {
        let userData = try closure()
        print("User data received: \(userData)")
    } catch Failure.badNetwork(let message) {
        print(message)
    } catch {
        print("Fetch error")
    }
}

fetchUserData(using: fetchLocal)
fetchUserData(using: fetchRemote)

// But what happened if you want to use error propagation from fetchUserData ? 

func fetchUserDataThrowing(using closure: () throws -> String) throws {
    let userData = try closure()
    print("User data received: \(userData)")
}

do {
    try fetchUserDataThrowing(using: fetchLocal)
} catch Failure.badNetwork(let message) {
    print(message)
} catch {
    print("Fetch error")
}

// But this code has a problem: fetchUserData() could be called elsewhere in our app, perhaps more than once – it's going to get awfully messy having all that try/catch code in there, particularly the times we use fetchLocal() and know for a fact it won't throw

// Solution: Retrows 

func fetchUserDataRethrows(using closure: () throws -> String) rethrows {
    let userData = try closure()
    print("User data received: \(userData)")
}


do {
    try fetchUserDataRethrows(using: fetchLocal)
} catch Failure.badNetwork(let message) {
    print(message)
} catch {   
    print("Fetch error")
}

// The warning here is that the rethrows checks if the function used is already throwing an error, otherwise will warn programmer for unnecesarry do try catch block, so the correct call will be: 

fetchUserDataRethrows(using:fetchLocal)

// and for a throwing function: 


do {
    try fetchUserDataRethrows(using: fetchRemote)
} catch Failure.badNetwork(let message) {
    print(message)
} catch {
    print("Fetch error")
}


