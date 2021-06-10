//
//  ContentView.swift
//  Animations
//
//  Created by Brandon Stephens on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation = 0.0
    
    var body: some View {
        Button("Tap") {
            withAnimation(.interpolatingSpring(stiffness: 512, damping: 16)) {
                self.rotation += 360
            }
        }
        .padding(48)
        .background(Color.yellow)
        .foregroundColor(.black)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
