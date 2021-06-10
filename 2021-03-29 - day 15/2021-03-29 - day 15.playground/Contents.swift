// https://www.hackingwithswift.com/100/swiftui/15

import UIKit

// properties

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "Cha-cha-cha-changes \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "Cha-cha-cha-changes \(oldValue) to \(clothes)")
        }
    }
    
    var age: Int
    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
    
    static var fav = "Lalalalalal"
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts", age: 23, shoes: "sneakers")
let other = Person(clothes: "short skirts", age: 34, shoes: "high heels")
taylor.describe()
other.describe()

taylor.clothes = "Poopoo"

var fan = Person(clothes: "Lalal", age: 23, shoes: "Lalal")
print(fan.ageInDogYears)

// static properties and methods

print(Person.fav)

// access control

class Fan {
    private var name: String?
}

// polymorphism and typecasting

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "Good"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "Not so good"
    }
}

class LiveAlbum: Album {
    var venue: String
    
    init(name: String, venue: String) {
        self.venue = venue
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "Mostly good"
    }
}

var taylorSwift = StudioAlbum(name: "Lalala", studio: "PooPoop")
var fearless = StudioAlbum(name: "Peepepepe", studio: "asdfasdf")
var live = LiveAlbum(name: "Live", venue: "The Place")
var albums: [Album] = [taylorSwift, fearless, live]

for album in albums {
    print(album.getPerformance())
    
    if let studio = album as? StudioAlbum {
        print(studio.studio)
    }
    
    if let live = album as? LiveAlbum {
        print(live.venue)
    }
}

// forced downcasting (typecasting)

var albums2: [Album] = [taylorSwift, fearless]

for album in albums2 {
    print(album.getPerformance())
    
    let studio = album as! StudioAlbum
    print(studio.studio)
}

for album in albums2 as! [StudioAlbum] {
    print(album.getPerformance())
    print(album.studio)
}

for album in albums2 as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.getPerformance())
    print(album.venue)
}

let number = 5
// let text = number as! String
let text = String(number)
print(text)

// closures

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

// trailing closure syntax
UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
