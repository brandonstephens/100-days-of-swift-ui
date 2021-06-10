//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brandon Stephens on 4/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    
    var body: some View {
        Button("Test") {
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("This is only a test!"), message: Text("Had this been an actual emergency official information would have followed."), dismissButton: .default(Text("Okay")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
