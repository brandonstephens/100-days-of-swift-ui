// https://www.hackingwithswift.com/100/swiftui/10

import UIKit

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")


print(poppy)

class Empty {}
let nothing = Empty()

// inheritance & overriding methods

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    
    override func makeNoise() {
        print("Yip!")
    }
}

let dogo = Poodle(name: "Dogo")
dogo.makeNoise()

// final classes

final class Song {
    var name: String;
    
    init(name: String) {
        self.name = name
    }
}

// copying objects

struct SingerStruct {
    var name = "Katy Perry"
}

var singer1 = SingerStruct()
print(singer1.name)

var singer2 = singer1
singer1.name = "Sia"
print(singer2.name)

class Singer {
    var name = "Katy Perry"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singer.name = "Sia"
print(singerCopy.name)


// deinitializers

class Person {
    var name = "Jane Doe"
    
    init() {
        print("alive")
    }
    
    func printGreeting() {
        print("Ello I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// mutability

class Sanger1 {
    var name = "La la la"
}
let sanger = Sanger1()
sanger.name = "Poo Poo"
print(sanger.name)

