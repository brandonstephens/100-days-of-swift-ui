//
//  ContentView.swift
//  HabitTracker
//
//  Created by Patrick Hill on 4/6/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink(destination:DetailView(activities:activities,activity: activity)) {
                        VStack(alignment:.leading) {
                            Text("\(activity.title)")
                            Text("\(activity.completed)")
                        }
                    }
                }
            }
            .navigationTitle(Text("Habits"))
            .navigationBarItems(trailing:
                Button(action:{
                    showingSheet.toggle()
                }) {
                    Text(Image(systemName: "plus"))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .frame(maxWidth:.infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(200)
                })
            
        }
        .sheet(isPresented: $showingSheet, content: {
            NewHabitView(activities: activities)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
