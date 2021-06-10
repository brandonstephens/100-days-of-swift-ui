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
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showScore = false
    @State private var scoreMessage = ""
    @State private var scoreTitle = ""
    @State private var score = 0
    
    let textColor = Color.black
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.yellow, .orange, .red]),
                startPoint: .top, endPoint: .bottom
            )
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
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
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
