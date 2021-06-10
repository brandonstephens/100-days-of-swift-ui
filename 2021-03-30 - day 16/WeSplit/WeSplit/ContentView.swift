//
//  ContentView.swift
//  WeSplit
//
//  Created by Brandon Stephens on 3/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("What you want?")
                    Text("What else?")
                    Text("How bout this?")
                }
                Section {
                    TextField("What is your name?", text: $name)
                    Text("👤 \(name)")
                }
                Section {
                    Button("👆 Tap Count \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(0 ..< students.count) {
                            Text(self.students[$0])
                        }
                    }
                }
                
                Section {
//                    ForEach(0 ..< 100) { number in
//                        Text("Row \(number)")
//                    }
                    ForEach(0 ..< 100) {
                        Text("Row \($0)")
                    }
                }
            }
        
            .navigationBarTitle("🤑 WeSplit")
            //.navigationBarTitle(Text("WeSplit"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
