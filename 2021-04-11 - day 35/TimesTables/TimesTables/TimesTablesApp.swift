//
//  TimesTablesApp.swift
//  TimesTables
//
//  Created by Brandon Stephens on 4/11/21.
//

import SwiftUI

enum choice {
    case base
    case round
}

enum screens {
    case settings
    case practice
    case results
}

enum rounds {
    case five
    case ten
    case all
}

struct Choice: Hashable {
    var symbol: String
}

struct Problem: Hashable {
    var base: Int
    var multiple: Int
    var answer: String
}

class GlobalEnv: ObservableObject {
    @Published var baseChoice = 6
    @Published var roundChoice = 1
    @Published var problems = [Problem]()
    @Published var activeView: screens = .settings
    
    @Published var bases = makeBases(max: 12)
    @Published var rounds = [
        Choice(symbol: "5.circle.fill"),
        Choice(symbol: "10.circle.fill"),
        Choice(symbol: "infinity.circle.fill")
    ]
    
    func handleBase(_ index: Int) {
        self.baseChoice = index
    }
    
    func handleRound(_ index: Int) {
        self.roundChoice = index
    }
}

@main
struct TimesTablesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalEnv())
        }
    }
}
