// https://www.hackingwithswift.com/sixty/7/1/creating-your-own-structs

import UIKit

struct Sport {
    var name: String
}

// structs

var tennis = Sport(name: "Tennis")

print(tennis.name)

tennis.name = "Lawn Tennis"

print(tennis.name)

// computed properties

struct Sport2 {
    var name: String
    var isOlympic: Bool
    
    var olympicStatus: String {
        if isOlympic {
            return "\(name) is an Olympic sport."
        } else {
            return "\(name) is a baby game."
        }
    }
}

let chessBoxing = Sport2(name: "Chess Boxing", isOlympic: false)

print(chessBoxing.olympicStatus)

// property observers

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var p = Progress(task: "Loading", amount: 0)
p.amount = 30
p.amount = 80
p.amount = 100

// methods

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
print(london.collectTaxes())

// mutating methods

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person)

// strings

let string = "La la la"

print(string.count)

print(string.hasPrefix("La"))
print(string.hasPrefix("Doe"))
print(string.uppercased())
print(string.sorted())

// arrays

var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
print(toys.count)
toys.firstIndex(of: "Buzz")
toys.sorted()
toys.remove(at: 0)

var fib = [1,1,2,3,5,8]
print(fib, fib.sorted())

let tens = [ 30,20,10]
tens.sorted()
print(tens)

