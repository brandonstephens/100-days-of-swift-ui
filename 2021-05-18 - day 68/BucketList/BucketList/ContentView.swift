//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Stephens on 5/18/21.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    // operator overloading
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}

struct ContentView: View {
//    let values = [1,5,3,6,2,9].sorted()
    
//    let users = [
//        User(firstName: "Arnold", lastName: "Schwarzenegger"),
//        User(firstName: "Bruce", lastName: "Willis"),
//        User(firstName: "Keanue", lastName: "Reeves")
//    ].sorted {
//        $0.lastName < $1.lastName
//    }
    
    let users = [
        User(firstName: "Arnold", lastName: "Schwarzenegger"),
        User(firstName: "Bruce", lastName: "Willis"),
        User(firstName: "Keanue", lastName: "Reeves")
    ].sorted()
    
    var body: some View {
//        List(values, id: \.self) {
//            Text(String($0))
//        }
        
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
