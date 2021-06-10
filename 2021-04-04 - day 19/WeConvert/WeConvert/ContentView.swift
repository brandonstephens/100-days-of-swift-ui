//
//  ContentView.swift
//  WeConvert
//
//  Created by Brandon Stephens on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var inputUnitIndex = 0
    @State private var outputUnitIndex = 3
    
    let units: [String] = ["in", "ft", "mi", "cm", "m", "km"]
    
    var inputValue: Double {
        return Double(input) ?? 0
    }
    
    var outputValue: Double {
        return Double(outPutMeasurement.value)
    }
    
    var baseMeasurement: Measurement<UnitLength> {
        switch inputUnitIndex {
        case 0:
            return Measurement(value: inputValue, unit: UnitLength.inches)
        case 1:
            return Measurement(value: inputValue, unit: UnitLength.feet)
        case 2:
            return Measurement(value: inputValue, unit: UnitLength.miles)
        case 3:
            return Measurement(value: inputValue, unit: UnitLength.centimeters)
        case 4:
            return Measurement(value: inputValue, unit: UnitLength.meters)
        case 5:
            return Measurement(value: inputValue, unit: UnitLength.kilometers)
        default:
            return Measurement(value: 0, unit: UnitLength.inches)
        }
    }
    
    var outPutMeasurement: Measurement<UnitLength> {
        switch outputUnitIndex {
        case 0:
            return baseMeasurement.converted(to: UnitLength.inches)
        case 1:
            return baseMeasurement.converted(to: UnitLength.feet)
        case 2:
            return baseMeasurement.converted(to: UnitLength.miles)
        case 3:
            return baseMeasurement.converted(to: UnitLength.centimeters)
        case 4:
            return baseMeasurement.converted(to: UnitLength.meters)
        case 5:
            return baseMeasurement.converted(to: UnitLength.kilometers)
        default:
            return baseMeasurement.converted(to: UnitLength.meters)
        }
    }
    
    func swapValues() -> Void {
        let tempIndex = inputUnitIndex
        input = String(outputValue)
        inputUnitIndex = outputUnitIndex
        outputUnitIndex = tempIndex
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Distance", text: $input)
                        .keyboardType(.decimalPad)
                }
                
                Section() {
                    Picker("Unit", selection: $inputUnitIndex) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Text("\(outputValue, specifier: "%.2f")")
                }
                
                Section() {
                    Picker("Unit", selection: $outputUnitIndex) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                Button(action: swapValues, label: {
                    Text("🔀 Swap input/output")
                })
            }
            .navigationBarTitle("🤓 WeConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
