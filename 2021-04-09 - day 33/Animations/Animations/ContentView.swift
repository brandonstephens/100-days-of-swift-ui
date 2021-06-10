//
//  ContentView.swift
//  Animations
//
//  Created by Brandon Stephens on 4/9/21.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var enabled = false
    var body: some View {
        VStack {
            Button("Tap") {
                withAnimation {
                    self.enabled.toggle()
                }
            }
            
            if enabled {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 240, height: 240)
//                    .transition(.scale)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
