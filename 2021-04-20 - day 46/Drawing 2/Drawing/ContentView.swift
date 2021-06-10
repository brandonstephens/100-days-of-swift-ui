//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct ColorRect: View {
    var amount = 0.0
    var steps = 100
    
    func color(for value: Int, brightness: Double) -> Color{
        var target = Double(value) / Double(self.steps) + self.amount
        
        if target > 1 {
            target -= 1
        }
        
        return Color(hue: target, saturation: 1, brightness: brightness)
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.15)
                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: 2)
            }
        }.drawingGroup()
    }
}

struct ContentView: View {
    @State private var color = 0.0
    
    var body: some View {
        VStack {
            ColorRect(amount: self.color)
                .frame(width: 240, height: 240)
            
            Slider(value: $color)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
