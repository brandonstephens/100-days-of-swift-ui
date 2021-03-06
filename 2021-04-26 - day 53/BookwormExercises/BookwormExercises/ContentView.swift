//
//  ContentView.swift
//  BookwormExercises
//
//  Created by Brandon Stephens on 4/26/21.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5 )
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
//        VStack {
//            PushButton(title: "Remember Me", isOn: $rememberMe) // passes the binding not the boolean
//
//            Text(rememberMe ? "On" : "Off")
//        }
        
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
