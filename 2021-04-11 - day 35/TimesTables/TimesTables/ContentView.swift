//
//  ContentView.swift
//  TimesTables
//
//  Created by Brandon Stephens on 4/11/21.
// https://www.hackingwithswift.com/guide/ios-swiftui/3/3/challenge

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12").environmentObject(GlobalEnv())
    }
}

// show random questions
// show score at the end
// allow another game

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnv
    
    var body: some View {
        switch env.activeView {
            case .settings:
                SettingsView()
            case .practice:
                PracticeView()
            case .results:
                ResultsView()
        }
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Image(systemName: "tablecells.fill")
                .foregroundColor(.white)
                .font(.system(size: 36))

            Text("Times Tables")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
    }
}


