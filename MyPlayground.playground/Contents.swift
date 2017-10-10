//: Playground - noun: a place where people can play

// Important notes meanings from Chapter 1:

/*
 Property observers: willSet contains a special value called newValue
                     didSet contains a special value called oldVale
 
 Static Methods can't access properties that belongs to instance instead of class (static)
 
 Access Control
     Public
     Internal
     Private
     Fileprivate
 */

import UIKit

print("*********************************** Properties ***********************************")

// Property observers
// willSet and didSet

struct RandomPerson{
    // static properties belogs to the type instaed to the instance:
    
    static var favoriteSport = "Mountain bike"
    
    var clothes: String {
        willSet{
            updateUI("Will update property clothes from: \(clothes) to \(newValue)")
        }
        didSet{
            updateUI("Did update property clothes with \(clothes) where old value was \(oldValue)")
        }
    }
    
    var age: Int
    
    var luckyNumber: Int {
        return age * 2
    }
    
    func updateUI(_ msg: String){
        print("\(msg)")
    }
    
    static func printInfo() {
            print("\(favoriteSport)")
        
    }
    // static methods
}

var javier = RandomPerson(clothes: "shorts", age: 12)

javier.clothes = "pants"

//print(javier.luckyNumber)
//print(RandomPerson.favoriteSport)

print("*********************************** Typecasting ***********************************")

class Album {
    var name: String
    init(name: String) {
        self.name = name
    }
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
    
}

class StudioAlbum: Album {
    var studio: String
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
    
}

class LiveAlbum: Album {
    var location: String
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio:    "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo",
                           location: "New York")
var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
    
    
}


var test: String?

var test2: String? = test!

if let test3 = test2 {
    print("\(test3) not null")
} else {
    print("null bitch")
}


