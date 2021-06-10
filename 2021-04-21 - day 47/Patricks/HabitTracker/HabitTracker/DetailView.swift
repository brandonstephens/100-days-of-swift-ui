//
//  DetailView.swift
//  HabitTracker
//
//  Created by Patrick Hill on 4/6/21.
//

import SwiftUI

struct DetailView: View {
    var activities:Activities
    var activity: Activity
    @State private var completed: Int
    @Environment(\.presentationMode) var presentationMode
    
    init(activities:Activities,activity:Activity) {
        self.activities = activities
        self.activity = activity
        _completed = State(initialValue: activity.completed)
    }
    
    func saveActivity() {
        for key in 0..<activities.activities.count {
            if(activities.activities[key].id == self.activity.id) {
                print(activities.activities[key].completed)
                activities.activities[key] = Activity(
                    id: activity.id,
                    title: activity.title,
                    description: activity.description,
                    completed: self.completed
                )
            }
        }
        
    }
    
    var body: some View {
        VStack {
            Text(activity.description)
            .padding()
            
            VStack(alignment:.leading) {
                Stepper(
                    onIncrement: { completed += 1 },
                    onDecrement: { completed -= 1 },
                    label: {
                        Text("Completed \(completed)")
                    })
            }
            .padding(32)
            
            Spacer()
            
            Button(action:{
                saveActivity()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .frame(maxWidth:.infinity)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(200)
                    .padding()
            }
        }
        .navigationTitle(activity.title)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
