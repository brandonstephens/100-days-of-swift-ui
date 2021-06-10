// https://www.hackingwithswift.com/sixty/6/6/using-closures-as-parameters-when-they-accept-parameters

import UIKit

// params

func travel(action: (String) -> Void) {
    print("Ready")
    action("London")
    print("Done")
}

travel { (place: String) in
    print("La la la \(place)")
}

func fetchData(then parse: (String) -> Void) {
    let data = "Success!"
    parse(data)
}

fetchData { (data: String) in
    print("Data received: \(data)")
}

func fix(item: String, payBill: (Int) -> Void) {
    print("I've fixed your \(item)")
    payBill(450)
}

fix(item: "roof") { (bill: Int) in
    print("You want $\(bill) for that? Outrageous!")
}

// return values

func travel2(action: (String) -> String) {
    print("Leaving")
    let desc = action("London")
    print(desc)
    print("Done")
}

travel2 { (place: String) -> String in
    return "I'm going to \(place)."
}

func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    var current = values[0]
    
    for value in values[1...] {
        current = closure(current, value)
    }
    
    return current
}

let numbers = [10,20,30,40,50]

let sum = reduce(numbers) { (total: Int, next: Int) in
    total + next
}

let max = reduce(numbers) { (max: Int, next: Int) in
    max > next ? max : next
}

let min = reduce(numbers) { (min, next) in
    min < next ? min : next
}

let fac = reduce(numbers) { (fac, next) in
    fac * next
}

let sum2 = reduce(numbers, using: +)

print(sum)
print(sum2)
print(max)
print(min)
print(fac)


// shorthand param names

travel2 { (place: String) -> String in
    return "lalala to \(place)"
}

travel2 { place in
    "the leaky cauldron that's in \(place)"
}

travel2 {
    "Poo poo pee pee \($0)"
}


// multi params

func travel3(action: (String, Int) -> String) {
    print("Ready")
    let desc = action("London", 60)
    print(desc)
    print("Done")
}

travel3 {
    "Going to \($0) at \($1)mph"
}

// return closures

func travel4() -> (String) -> Void {
    return {
        print("La la la \($0)")
    }
}

let result = travel4()

result("London")

let result2 = travel4()("Blondon")

// capturing values

func travel5() -> (String) -> Void {
    var counter = 1
    
    return {
        print("Test \(counter) Lalala \($0)")
        counter += 1
    }
}

let res = travel5()
res("Where")
res("Who")
res("Why")

print(1.0 > 0)
