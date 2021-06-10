//
//  ContentView.swift
//  Edutainment
//
//  Created by Patrick Hill on 3/5/21.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var startGame:Bool = false
    @Published var difficulty:Double = 1
    @Published var questionCount:Double = 5
    @Published var score:Int = 0
    @Published var correctAnswerCount:Int = 0
}

struct ContentView: View {
    var body: some View {
        AppWrapper().environmentObject(GameSettings())
    }
}

struct AppWrapper: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        Group {
            if (settings.startGame) {
                GameView()
            } else {
                QuestionsView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
