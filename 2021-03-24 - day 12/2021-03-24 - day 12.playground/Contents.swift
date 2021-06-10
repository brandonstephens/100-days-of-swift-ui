// https://www.hackingwithswift.com/100/swiftui/12

import UIKit

// missing data & optionals

var age: Int? = nil
age = 38

// unwrapping

var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name")
}

// guard

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("No name")
        return
    }
    
    print("Hello \(unwrapped)")
}

// force unwrapping

let str = "5"
let num = Int(str)! // will crash if you pass a non-numeral

// implicitly unwrapped optionals

let age2: Int! = nil

// nil coalescing

func username(for id: Int) -> String? {
    if id == 1 {
        return "Bob"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"
print(user)

// optional chainging

let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()

// optional try

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("Good")
} catch {
    print("Nope")
}

if let result = try? checkPassword("password") {
    print("Good, result was \(result)")
} else {
    print("Not good")
}

try! checkPassword("sekrit")
print("ok")

// failable initializers

let str2 = "4"
let num2 = Int(str2)

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let person = Person(id: "asdfsd")
print(person?.id)

// typecasting

class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Woff")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
