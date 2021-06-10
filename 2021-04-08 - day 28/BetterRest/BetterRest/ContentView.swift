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
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0

        return Calendar.current.date(from: components) ?? Date()
    }
    
    var bedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        var output: String
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            output = formatter.string(from: sleepTime)
        } catch {
            output = "Sorry, issue calculating."
        }
        
        return output
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Text("Your ideal bed time is:").font(.headline).padding(.top, 24).foregroundColor(.gray)
                    Text("\(bedTime)").font(.largeTitle).fontWeight(.black).foregroundColor(.blue)
                }

                Form {
                    Section {
                        Text("When do you want to wake up?").font(.headline)
                        
                        DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                    }
                    
                    Section {
                        Text("Desired amount of sleep").font(.headline)
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    
                    Section {
                        Text("Daily coffee intake?").font(.headline)
                        
                        Picker("\(coffeAmount) \(coffeAmount == 1 ? "cup" : "cups")", selection: $coffeAmount) {
                            ForEach(0 ..< 20) { choice in
                                Text("\(choice) \(choice == 1 ? "cup" : "cups")")
                            }
                            
                        }
                    }
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
