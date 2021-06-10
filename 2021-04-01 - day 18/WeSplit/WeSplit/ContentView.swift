//
//  ContentView.swift
//  WeSplit
//
//  Created by Brandon Stephens on 3/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipIndex = 2
    
    let tipPercentages: [Int] = [10,15,20,25,0]
    let maxPeople: Int = 25
    
    var orderAmount: Double {
        return Double(checkAmount) ?? 0
    }
    
    var people: Double {
        return Double(numberOfPeople) ?? 0
    }
    
    var grandTotal: Double {
        return orderAmount + tipValue
    }
    
    var totalPerPerson: Double {
        return grandTotal / people
    }
    
    var tipPercentage: Double {
        return Double(tipPercentages[tipIndex])
    }
    
    var tipValue: Double {
        return orderAmount / 100 * tipPercentage
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total Bill")) {
                    TextField("Enter total amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
//                Section(header: Text("How many people are paying?")) {
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(1...maxPeople, id: \.self) { i in
//                            Text("\(i) people")
//                        }
//                    }
//                }
                
                Section(header: Text("How many people are paying?")) {
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Tip amount ($\(tipValue, specifier: "%.2f"))")) {
                    Picker("Tip percentage", selection: $tipIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total with tip")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }

                Section(header: Text("Each person owes:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("🤑 WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
