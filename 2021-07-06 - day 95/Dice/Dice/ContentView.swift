//
//  ContentView.swift
//  Dice
//
//  Created by Brandon Stephens on 7/6/21.
//

import SwiftUI

// https://www.hackingwithswift.com/guide/ios-swiftui/7/3/challenge

struct Die: Codable, Identifiable {
    var id: UUID
    var sides: Int
    var result: Int?
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dice = [Die]()
    @State private var showAddDie = false
    @State private var tempSides = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.dice, id: \.id) { die in
                        HStack {
                            Text("\(die.sides) sides: ")
                            Spacer()
                            Text("\(die.result ?? 0)")
                        }
                    }
                }
                Button(action: {
                    showAddDie = true
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle")
                        
                        Text("Add")
                    }
                })
            }
            .navigationBarTitle(Text("Dice"))
            .navigationBarItems(trailing: Button(action: {
                roll()
            }, label: {
                HStack {
                    Image(systemName: "die.face.5")
                    
                    Text("Roll Dice")
                }
            }))
        }
        .sheet(isPresented: $showAddDie, content: {
            NavigationView {
                VStack {
                    Form {
                        Stepper("Sides: \(tempSides)", value: $tempSides, in: 1...100)
                    }
                    Button(action: {
                        dice.append(Die(id: UUID(), sides: tempSides))
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                }
                .navigationBarTitle("Add Die")
                .navigationBarItems(trailing: Button("Cancel", action: dismiss))
            }
        })
    }
    
    func dismiss() {
        showAddDie = false
    }

    func roll() {
        let newArr: [Die] = self.dice.map { die in
            return Die(id: die.id, sides: die.sides, result: Int.random(in: 1...die.sides))
        }
        
        dice = newArr
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 mini")
    }
}
