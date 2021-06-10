//
//  ContentView.swift
//  Accessibility
//
//  Created by Brandon Stephens on 5/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
//        Image(decorative: "character")
//            .accessibility(hidden: true)
        
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .combine)
        
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibility(label: Text("Your score is 1000"))
        
        Slider(value: $estimate, in: 0...50)
            .padding()
            .accessibility(value: Text("\(Int(estimate))"))
        
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .accessibility(value: Text("\(rating) our of 5"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
