//
//  GameView.swift
//  Edutainment
//
//  Created by Patrick Hill on 3/5/21.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var settings: GameSettings
    
    @State private var answer = ""
    @State private var correctAnswer:Int = 0
    @State private var question = ""
    @State private var questionIndex:Double = 0
    @State private var showFinalScore = false
    
    var body: some View {
        VStack {
            if ( showFinalScore ) {
                VStack(spacing:24) {
                    Text("Final Score: \(settings.score)")
                        .font(.largeTitle)
                    Text("You got \(settings.correctAnswerCount) out of \(settings.questionCount,specifier: "%g") correct.")
                        .font(.title3)
                    ButtonCustom(
                        text:"New Game",
                        action:{
                            settings.score = 0
                            settings.correctAnswerCount = 0
                            settings.startGame = false
                        }
                    )
                }
            } else {
                VStack {
                    VStack {
                        Text("Score: \(settings.score)")
                            .font(.largeTitle)
                    }
                    VStack {
                        Text(question)
                            .font(.largeTitle)
                            .padding(.bottom,48)
                        
                        TextField("enter your answer",text: $answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }.padding(32)
                    
                    ButtonCustom(
                        text:"Check Answer",
                        action:{
                            checkAnswer()
                        }
                    )
                }
                .onAppear(perform: {
                    askQuestion()
                })
            }
        }
    }
    
    func askQuestion() {
        let randomInt1 = Int.random(in: 1...Int(settings.difficulty))
        let randomInt2 = Int.random(in: 1...12)
        
        question = ("What is \(randomInt1) x \(randomInt2)?")
        correctAnswer = randomInt1 * randomInt2
        
    }
    
    func checkAnswer() {
        questionIndex += 1
        
        if (String(correctAnswer) == answer) {
            settings.score += 1
            settings.correctAnswerCount += 1
        } else {
            settings.score -= 1
        }
        
        if (questionIndex < settings.questionCount) {
            answer = ""
            askQuestion()
        } else {
            showFinalScore = true
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

