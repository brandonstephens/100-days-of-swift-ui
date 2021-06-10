//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let point = CGPoint(x: rect.midX, y: rect.minY)
        let xFactor:CGFloat = 0.25
        let yFactor: CGFloat = 0.4
        
        path.move(to: point) // start
        path.addLine(to: CGPoint(x: rect.maxX * (1.0 - xFactor), y: rect.maxY * yFactor)) // point
        
        path.move(to: point) // start
        path.addLine(to: CGPoint(x: rect.maxX * xFactor, y: rect.maxY * yFactor))
        
        path.move(to: point) // start
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

struct ContentView: View {
    @State private var lineWidth = 8.0
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: CGFloat(lineWidth), lineCap: .round, lineJoin: .round))
                .frame(width: 240, height: 240)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(stiffness: 512, damping: 16)) {
                        if lineWidth >= 80 {
                            self.lineWidth = 8
                        } else {
                            self.lineWidth += 8
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
