//
//  ContentView.swift
//  WordScramble
//
//  Created by Brandon Stephens on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
        return Text("Lalal")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
