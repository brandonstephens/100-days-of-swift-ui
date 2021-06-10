//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Stephens on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack {
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List {
                        HStack {
                            Text("Score: ").font(.title).foregroundColor(.gray)
                            Text("\(score)").font(.title).fontWeight(.black).foregroundColor(.yellow)
                        }
                        
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle.fill").foregroundColor(.yellow)
                                Text(word)
                            }
                        }
                    }
                }
                .padding(.top, 8)
                .navigationBarTitle(rootWord)
                .navigationBarItems(trailing: Button(action: startGame) {
                    Text("Restart").foregroundColor(.yellow)
                })
                .onAppear(perform: startGame)
                .alert(isPresented: $showError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Okay")))
                }
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try again!")
            return
        }
                
        guard isRootWord(word: answer) else {
            wordError(title: "Nope", message: "Can't use the root word as an answer.")
            return
        }

        guard isTooShort(word: answer) else {
            wordError(title: "Too short", message: "Words must be at least 3 letters.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not in root word", message: "Try again!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Not a real word", message: "Try again!")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count * 100
        newWord = ""
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                usedWords = []
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not loat start.txt")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isTooShort(word: String) -> Bool {
        return !(word.count < 3)
    }
    
    func isRootWord(word: String) -> Bool {
        return !(word == rootWord)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
