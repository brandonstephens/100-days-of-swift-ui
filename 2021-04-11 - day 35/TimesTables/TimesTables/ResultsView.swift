//
//  ResultsView.swift
//  TimesTables
//
//  Created by Brandon Stephens on 4/13/21.
//

import SwiftUI

func isCorrect(base: Int, multiple: Int, answer: Int) -> Bool {
    return base * multiple == answer ? true : false
}

func resetGame(env: GlobalEnv) {
    env.activeView = .settings
}

struct ResultsView: View {
    @EnvironmentObject var env: GlobalEnv
    
    var body: some View {
        ZStack {
            Background()
            
            VStack(alignment: .center, spacing: 16) {
                Header().padding()
                
                VStack() {
                    ForEach(0..<env.problems.count) { problem in
                        HStack {
                            Text("\(env.problems[problem].base) x \(env.problems[problem].multiple)")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Image(
                                systemName: isCorrect(
                                    base: env.problems[problem].base,
                                    multiple: env.problems[problem].multiple,
                                    answer: Int(env.problems[problem].answer) ?? -1
                                ) ? "checkmark.circle.fill" : "xmark.circle.fill"
                            ).foregroundColor(.white).font(.title).opacity(isCorrect(
                                base: env.problems[problem].base,
                                multiple: env.problems[problem].multiple,
                                answer: Int(env.problems[problem].answer) ?? -1
                            ) ? 0.8 : 0.4)
                        }
                    }
                }
                
                Button(action: {
                    resetGame(env: self.env)
                }) {
                    HStack(alignment: .center, spacing: 8) {
                        Text("Play Again").font(.title).foregroundColor(.white)
                        Image(systemName: "arrow.counterclockwise.circle.fill").foregroundColor(.white).font(.title)
                    }
                }
                .padding()
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.white, lineWidth: 4.0))
                .shadow(color: Color.red.opacity(0.17), radius: 16, x: 0.0, y: 4)
                .shadow(color: Color.red.opacity(0.25), radius: 2, x: 0.0, y: 2)
            }
        }
    }
}
