//
//  PracticeView.swift
//  TimesTables
//
//  Created by Brandon Stephens on 4/13/21.
//

import SwiftUI

func calcResults(env: GlobalEnv) {
    // tk calc answers
    // tk store results for display later
    
    env.activeView = .results
}

struct PracticeView: View {
    @EnvironmentObject var env: GlobalEnv
    @State private var activeTab = 0
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Header().padding()
                
                TabView(selection: $activeTab) {
                    ForEach(0..<env.problems.count) { problem in
                        VStack {
                            Text("\(env.problems[problem].base) x \(env.problems[problem].multiple)")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            TextField(
                                "Answer",
                                text: $env.problems[problem].answer,
                                onCommit: {
                                    withAnimation(.default) {
                                        activeTab += 1
                                    }
                                }
                            )
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.title)
                                .padding()
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 64)
                        .tag(problem)
                    }
                    
                    
                    Button(action: {
                        calcResults(env: self.env)
                    }) {
                        HStack(alignment: .center, spacing: 8) {
                            Text("Finish").font(.title).foregroundColor(.white)
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.white).font(.title)
                        }
                    }
                    .padding()
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.white, lineWidth: 4.0))
                    .shadow(color: Color.red.opacity(0.17), radius: 16, x: 0.0, y: 4)
                    .shadow(color: Color.red.opacity(0.25), radius: 2, x: 0.0, y: 2)
                    .tag(env.problems.count)
                }
                .tabViewStyle(PageTabViewStyle())
                
            }
        }
    }
}
