//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Brandon Stephens on 4/7/21.
//

import SwiftUI

let moves: [String] = ["✊ Rock", "🤚 Paper", "✌️ Scissors"]

struct ParamTitle: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .opacity(0.6)
    }
}

struct Param: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.06), Color.black.opacity(0.02)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
}

struct ContentView: View {
    @State private var randomOutcome = Bool.random()
    @State private var randomMove = Int.random(in: 0 ..< moves.count)
    @State private var score = 0
    
    var body: some View {
        NavigationView() {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 36) {
                    VStack(alignment: .leading, spacing: 8) {
                        ParamTitle("Your score:")
                        Param("\(score)")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ParamTitle("Current Move:")
                        Param("\(moves[randomMove])")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ParamTitle("You need to:")
                        Param("\(randomOutcome ? "Win" : "Loose")")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ParamTitle("Pick your move:")
                        
                        HStack() {
                            ForEach(0 ..< moves.count) { move in
                                Button(action: {
                                    pickMove(choice: move)
                                }, label: {
                                    Text("\(moves[move].replacingOccurrences(of: " ", with: "\n"))")
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 16)
                                })
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            }
                        }
                    }
                }.padding(16)
            }
            .navigationBarTitle(Text("👾 Game Simulator"))
        }
    }
    
    func pickMove(choice: Int) {
        var winningMove: Int
        
        switch randomMove {
        case 0:
            winningMove = 1
        case 1:
            winningMove = 2
        case 2:
            winningMove = 0
        default:
            winningMove = 0
        }
        
        if randomOutcome {
            if(winningMove == choice) {
                score += 100
                randomOutcome = Bool.random()
                randomMove = Int.random(in: 0 ..< moves.count)
            } else {
                randomOutcome = Bool.random()
                randomMove = Int.random(in: 0 ..< moves.count)
            }
        } else {
            if(winningMove != choice) {
                score += 100
                randomOutcome = Bool.random()
                randomMove = Int.random(in: 0 ..< moves.count)
            } else {
                randomOutcome = Bool.random()
                randomMove = Int.random(in: 0 ..< moves.count)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
