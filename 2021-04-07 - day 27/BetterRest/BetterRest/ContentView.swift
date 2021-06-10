//
//  ContentView.swift
//  BetterRest
//
//  Created by Brandon Stephens on 4/7/21.
//

import SwiftUI


struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = ContentView.defaultWakeTime
    @State private var coffeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?").font(.headline)
                    
                    DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep").font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake?").font(.headline)
                    
                    Stepper(value: $coffeAmount, in: 0...20, step: 1) {
                        Text("\(coffeAmount) \(coffeAmount == 1 ? "cup" : "cups")")
                    }
                }
                
            }
            .navigationBarTitle(Text("😴 Better Rest"))
            .navigationBarItems(trailing: Button(action: calcBedtime) {
                    Text("Calculate")
                }
            )
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    func calcBedtime() {
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, issue calculating."
        }
        
        showAlert = true

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
