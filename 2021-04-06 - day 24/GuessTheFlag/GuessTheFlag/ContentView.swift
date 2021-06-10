//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brandon Stephens on 4/5/21.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    let FlagCorner = RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
    
    var body: some View {
    Image(image)
        .renderingMode(.original)
        .clipShape(FlagCorner)
        .overlay(FlagCorner.stroke(Color.black.opacity(0.6), lineWidth: 1))
        .shadow(color: Color.red.opacity(0.2), radius: 16, x:0, y:8)
        .shadow(color: Color.red.opacity(0.4), radius: 2, x:0, y:4)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showScore = false
    @State private var scoreMessage = ""
    @State private var scoreTitle = ""
    @State private var score = 0
    
    let textColor = Color.black
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 24) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(textColor)
                    Text(countries[correctAnswer])
                        .fontWeight(.semibold)
                        .foregroundColor(textColor)
                        .font(.largeTitle)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                }
                
                HStack {
                    Text("Your score: ").foregroundColor(textColor)
                    Text("\(score)").foregroundColor(textColor).fontWeight(.semibold)
                }
                
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 100
            scoreTitle = "Correct!"
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That flag is from \(countries[number])"
        }
        showScore = true
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")

    }
}
