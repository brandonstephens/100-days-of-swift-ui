// https://www.hackingwithswift.com/sixty/5/1/writing-functions

import UIKit
 
func printHelp () {
    let message = """
    Welcome to MyApp!

    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails.
    """
    
    print(message)
}

printHelp()

// params

func square(number: Int) {
    print(number * number)
}

square(number: 12)

// return values

func square2(number: Int) -> Int {
    return number * number
}

let result = square2(number: 8)

print(result)

// named params

func sayHello(to name: String) {
    print( "Hello, \(name)!")
}

sayHello(to: "Brandon")


// unnamed params

func greet(_ person: String) {
    print("Hello, \(person)!")
}
greet("Brandon")


// default params

func greet2(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet2("Brandon", nicely: false)

// variadic functions

print("Haters", "gonna", "hate")

func square4(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square4(numbers: 4,8,16)

// throwing

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
    print("The password is good!")
} catch {
    print("Nope")
}

// inout - allows var to change outside of function scope
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)

