//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6
    @State private var width = 1.0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: CGFloat(Int(width)))
                .frame(width: 240, height: 240)
            
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text("Inner radius: \(Int(innerRadius))").font(.caption).foregroundColor(.gray)
                    Slider(value: $innerRadius, in: 10...150, step: 1)
                }

                Group {
                    Text("Outer radius: \(Int(outerRadius))").font(.caption).foregroundColor(.gray)
                    Slider(value: $outerRadius, in: 10...150, step: 1)
                }

                Group {
                    Text("Distance: \(Int(distance))").font(.caption).foregroundColor(.gray)
                    Slider(value: $distance, in: 1...150, step: 1)
                }
                
                Group {
                    Text("Amount: \(amount, specifier: "%.2f")").font(.caption).foregroundColor(.gray)
                    Slider(value: $amount)
                }

                
                Group {
                    Text("Color").font(.caption).foregroundColor(.gray)
                    Slider(value: $hue)
                }

                Group {
                    Text("Width: \(Int(width))").font(.caption).foregroundColor(.gray)
                    Slider(value: $width, in: 1...16, step: 1)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
