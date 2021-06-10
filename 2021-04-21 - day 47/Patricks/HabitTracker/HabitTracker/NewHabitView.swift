//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Patrick Hill on 4/6/21.
//

import SwiftUI

struct NewHabitView: View {
    var activities:Activities
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    @State private var completed = 0
    
    var body: some View {
        VStack(alignment:.leading, spacing:32) {
            Text("New Habbit")
                .font(.largeTitle)
            
            VStack(alignment:.leading) {
                Text("Title")
                TextField("Enter a title", text:$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment:.leading) {
                Text("Description")
                TextField("Enter a description", text:$description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment:.leading) {
                Text("Completed")
                Stepper(
                    onIncrement: { completed+=1 },
                    onDecrement: { completed-=1 },
                    label: {
                        Text("Completed \(completed)")
                    })
            }
            
            Spacer()
            
            Button(action:{
                activities.appendActivity(
                    title: title,
                    description: description,
                    completed: completed
                )
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .frame(maxWidth:.infinity)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(200)
            }
        }
        .padding()
    }
}



//struct NewHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewHabitView()
//    }
//}
