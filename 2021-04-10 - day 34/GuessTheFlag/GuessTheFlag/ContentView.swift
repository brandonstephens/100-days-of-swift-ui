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
    @State private var rotations = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var scales: [CGFloat] = [1.0, 1.0, 1.0]
    
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
                        withAnimation(.default) {
                            self.flagTapped(number)
                        }
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(rotations[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(opacities[number])
                    .scaleEffect(scales[number])
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
        dimUntapped(number)
        
        if number == correctAnswer {
            self.rotations[number] += 360
            score += 100
            scoreTitle = "Correct"
            scoreMessage = "That flag is from \(countries[number])"
            showScore = true

        } else {
            self.scales[number] = 0.8
            scoreTitle = "Wrong"
            scoreMessage = "That flag is from \(countries[number])"
            showScore = true
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        resetAnimations()
    }
    
    func dimUntapped(_ number: Int) {
        for item in 0..<3 {
            if item != number {
                self.opacities[item] = 0.25
            }
        }
    }
    
    func resetAnimations() {
        for item in 0..<3 {
            self.scales[item] = 1.0
            self.opacities[item] = 1.0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")

    }
}
