//
//  ContentView.swift
//  WeSplit
//
//  Created by Brandon Stephens on 3/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages: [Int] = [10,15,20,25,0]
    let maxPeople: Int = 25
    
    var totalPerPerson: Double {
        let people = Double(numberOfPeople)
        let orderAmount = Double(checkAmount) ?? 0
        
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / people
        
        return amountPerPerson
    }
    
    var tipValue: Double {
        let tip = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount / 100 * tip
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total Bill")) {
                    TextField("Enter total amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How people are paying?")) {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1...maxPeople, id: \.self) { i in
                            Text("\(i) people")
                        }
                    }
                }
                
                Section(header: Text("Tip amount ($\(tipValue, specifier: "%.2f"))")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
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
