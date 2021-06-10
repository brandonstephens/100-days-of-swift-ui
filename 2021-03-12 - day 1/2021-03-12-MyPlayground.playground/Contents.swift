import UIKit
// Hacking With Swfit - Day 1
// 2021-03-12

// strings
var str = "Hello, playground"
var name = "Brandon"
str = "Goodbye"

// """ must be on their own lines
var multiStr = """
This goes
over mulitple
lines
"""

// hides the line returns
var multiStr2 = """
This goes \
over multiple \
lines
"""

// ints
var age = 38
var population = 8_000_000
population - age

// doubles
var pi = 3.14
var awesome = true

// interpolation
var str3 = "Pi is equal to \(pi)"
var results = "The test results are here: \(str3)"

// constants
let person = "Eleanor"

// type annotations
// --infered
let str4 = "Hello"
// --explicit
let album: String = "Dark Side of the Moon"
let year: Int = 1987
let height: Double = 1.78
let cool: Bool = true
