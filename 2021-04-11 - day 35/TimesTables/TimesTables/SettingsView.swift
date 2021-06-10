//
//  SettingsView.swift
//  TimesTables
//
//  Created by Brandon Stephens on 4/13/21.
//

import SwiftUI

func makeBases(max: Int) -> [Choice] {
    var output = [Choice]()
    
    for val in 0..<max {
        output.append(
            Choice(symbol: "\(val+1).circle")
        )
    }
    
    return output
}

func startPractice(env: GlobalEnv) {
    env.problems = [Problem]()
    
    let table = [0,1,2,3,4,5,6,7,8,9,10,11,12].shuffled()
    var count: Int
    
    switch env.roundChoice {
        case 0:
            count = 5
        case 1:
            count = 10
        default:
            count = table.count
    }
    
    for muliple in 0..<count {
        env.problems.append(Problem(base: env.baseChoice + 1, multiple: table[muliple], answer: ""))
    }
    
    env.activeView = .practice
}

struct SettingsView: View {
    @EnvironmentObject var env: GlobalEnv
    
    var body: some View {
        ZStack {
            Background()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Header()
                    Text("Practice your multiplication tables.")
                        .font(.caption)
                        .foregroundColor(.white)
                        .opacity(0.8)
                        .padding(.leading, 64)
                }.padding(16)
                
                VStack(alignment: .center, spacing: 48) {
                    NumberButtons(text: "Base Number", symbol: "number.square.fill", columns: 4, buttons: env.bases, handler: .base)
                    
                    NumberButtons(text: "Number of Rounds", symbol: "square.stack.fill", columns: 4, buttons: env.rounds, handler: .round)
                    
                    Button(action: {
                        startPractice(env: self.env)
                    }) {
                        HStack(alignment: .center, spacing: 8) {
                            Text("Start").font(.title).foregroundColor(.white)
                            Image(systemName: "play.circle.fill").foregroundColor(.white).font(.title)
                        }
                    }
                    .padding()
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.white, lineWidth: 4.0))
                    .shadow(color: Color.red.opacity(0.17), radius: 16, x: 0.0, y: 4)
                    .shadow(color: Color.red.opacity(0.25), radius: 2, x: 0.0, y: 2)
                }
                .padding()
            }
        }
    }
}

struct NumberButtons: View {
    @EnvironmentObject var env: GlobalEnv
    
    let text: String
    let symbol: String
    let columns: Int
    let buttons: [Choice]
    let handler: choice
    
    init(text: String, symbol: String, columns: Int, buttons: [Choice], handler: choice) {
        self.text = text
        self.symbol = symbol
        self.columns = columns
        self.buttons = buttons
        self.handler = handler
    }
    
    func activeChoice(_ handler: choice) -> Int {
        switch handler {
        case .base:
            return self.env.baseChoice
        case .round:
            return self.env.roundChoice
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Label(text: text, symbol: symbol)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: columns)) {
                ForEach(0..<buttons.count) { val in
                    Button(action: {
                        switch handler {
                        case .base:
                            self.env.handleBase(val)
                        case .round:
                            self.env.handleRound(val)
                        }
                    }) {
                        Image(systemName: "\(buttons[val].symbol)")
                            .foregroundColor(.white)
                            .font(.system(size: 48, weight: .semibold))
                    }
                    .clipShape(Circle())
                    .padding(4)
                    .shadow(color: Color.red.opacity(0.17), radius: 16, x: 0.0, y: 4)
                    .shadow(color: Color.red.opacity(0.25), radius: 2, x: 0.0, y: 2)
                    .opacity(activeChoice(handler) == val ? 1.0 : 0.4)
                }
            }.font(.largeTitle)
        }
    }
}

struct Label: View {
    let text: String
    let symbol: String
    
    init(text: String, symbol: String) {
        self.text = text
        self.symbol = symbol
    }
    
    var body: some View {
        HStack {
            Image(systemName: symbol).foregroundColor(.white)
            
            Text(text)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}
