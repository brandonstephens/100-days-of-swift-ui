//
//  ContentView.swift
//  iExpense
//
//  Created by Brandon Stephens on 4/14/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var name: String
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to The Shire, \(name)")
                
                Button("Close Sheet") {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding()
                
                List {
                    ForEach(numbers, id:\.self) { number in
                        Text("\(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                    
                Button("Add +") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }.navigationBarItems(leading: EditButton())
        }
    }
}

struct ContentView: View {
    @ObservedObject var user = User()
    @State private var showSeet = false
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        VStack {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName)")
                    .font(.title)
                    .padding()
                
                Group {
                    TextField("First name", text: $user.firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
   
                    TextField("Last name", text: $user.lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Tap Count: \(tapCount)") {
                    self.tapCount += 1
                }.padding()
                
                Spacer()
                
                Button("Show Sheet") {
                    self.showSeet.toggle()
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }.padding()
            }.padding()
        }.sheet(isPresented: $showSeet) {
            SecondView(name: user.firstName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
