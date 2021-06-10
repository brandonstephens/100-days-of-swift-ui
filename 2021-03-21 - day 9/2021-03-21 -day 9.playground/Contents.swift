// https://www.hackingwithswift.com/sixty/7/8/initializers

import UIKit

// memberwise initializers

struct User1 {
    var username: String
}

var user1 = User1(username: "me")
print(user1)

// init

struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Making a new user!")
    }
    
}

var user = User()
user.username = "me"
print(user)

// self - current instance

struct Person {
    var name: String
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

let me = Person(name: "Me")
print(me)

// lazy properties

struct FamilyTree {
    init() {
        print("Starting...")
    }
}

struct Person1 {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person1(name: "Ed")
print(ed)
ed.familyTree
print(ed)

// static props and methods

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
    
    
}

let eleanor = Student(name: "Eleanor")
let haddie = Student(name: "Haddie")
print(Student.classSize)

// access control

struct Person2 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My id is \(id)"
    }
}

let ed2 = Person2(id: "ed-209")
print(ed2)
print(ed2.identify())

