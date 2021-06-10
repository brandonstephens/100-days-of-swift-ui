// https://www.hackingwithswift.com/sixty/6/1/creating-basic-closures

import UIKit

// clousures

let driving = {
    print("I'm driving in my car")
}

driving()

// params

let driving2 = { (place: String, miles: Double) in
    print("I'm going to \(place) in my car \(miles) away.")
}

driving2("the place", 23.3)

// return values

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car."
}

let message = drivingWithReturn("London")
print(message)

// closures as parameters

func travel(action: () -> Void) {
    print("Leaving")
    action()
    print("There")
}

travel(action: driving)

// trailing closure syntax

func travel2(action: () -> Void) {
    print("Leaving")
    action()
    print("There")
}

travel2 {
    print("Driving about.")
}
