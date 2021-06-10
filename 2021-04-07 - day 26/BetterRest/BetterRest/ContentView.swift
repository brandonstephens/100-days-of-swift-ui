//
//  ContentView.swift
//  BetterRest
//
//  Created by Brandon Stephens on 4/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
        
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Pick a date", selection: $wakeUp, in: Date()..., displayedComponents: [.date])
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
            }
            .navigationBarTitle(Text("😴 Better Rest"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
