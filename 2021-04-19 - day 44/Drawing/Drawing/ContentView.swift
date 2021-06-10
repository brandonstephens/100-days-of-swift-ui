//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = 20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let orginalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            let rotatedPetal = orginalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct ColorCircle: View {
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
                Circle()
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
            ColorCircle(amount: self.color)
                .frame(width: 240, height: 240)
            
            Slider(value: $color)
        }
    }
    
    //    @State private var petalOffset = -20.0
    //    @State private var petalWidth = 100.0
    //
    //    var body: some View {
    //        VStack {
    //            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
    //                .fill(Color.yellow, style: FillStyle(eoFill: true))
    //
    //            Text("Offset")
    //            Slider(value: $petalOffset, in: -40...40)
    //                .padding([.horizontal, .bottom])
    //
    //            Text("Width")
    //            Slider(value: $petalWidth, in: 0...100)
    //                .padding([.horizontal])
    //        }
    //    }
    
    //    var body: some View {
    //        Text("Hello")
    //            .frame(width: 240, height: 240)
    //            .border(
    //                ImagePaint(
    //                        image: Image("cupcakes"),
    //                        sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
    //                        scale: 0.2)
    //                    ,
    //                width: 24
    //            )
    
    //        Capsule()
    //            .strokeBorder(
    //                ImagePaint(
    //                        image: Image("cupcakes"),
    //                        sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
    //                        scale: 0.2
    //                ),
    //                lineWidth: 32
    //            )
    //            .frame(width: 240, height: 360)
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
