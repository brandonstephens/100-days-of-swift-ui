//https://www.hackingwithswift.com/100/swiftui/4

import UIKit

// for loops
let count = 1...10

for number in count {
    print(number)
}

let albums = ["The White Album", "Rubber Soul", "Srgt Pepper's Lonely Heart Club Band", "Abby Road"]

for album in albums {
    print(album)
}

for _ in 1...5 {
    print("🤓")
}

// while loops
// will check before the first run
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

// repeat loops
// will always run once
repeat {
    print(number)
    number -= 1
} while number > 0


// exit loops
var countDown = 10

while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("🥱, I'm bored.")
        break
    }
    
    countDown -= 1
}
print("🚀")

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("🎯")
            break outerLoop
        }
    }
}

// skipping
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    
    print(i)
}

// infinite loops
var counter = 0

while true {
    print(counter)
    counter += 1
    
    if counter == 273 {
        break
    }
}
