//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var start: Angle
    var end: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let angleAdjustment = Angle.degrees(90)
        let offsetStart = start - angleAdjustment
        let offsetEnd = end - angleAdjustment
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width/2 - insetAmount,
            startAngle: offsetStart,
            endAngle: offsetEnd,
            clockwise: !clockwise
        )
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    var body: some View {
        
        //        Circle()
        //            .strokeBorder(Color.yellow, lineWidth: 48)
        
        Arc(start: .degrees(0), end: .degrees(270), clockwise: true)
            .strokeBorder(Color.yellow, lineWidth: 48)
        
        //        VStack(spacing: 48) {
        //            Spacer()
        //
        //            Arc(start: .degrees(0), end: .degrees(270), clockwise: true)
        //                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
        //                .frame(width: 96, height: 96)
        //
        //            Triangle()
        //                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
        //                .frame(width: 96, height: 96)
        //
        //            Path { path in
        //                path.move(to: CGPoint(x: 200, y: 100))
        //                path.addLine(to: CGPoint(x: 100, y: 300))
        //                path.addLine(to: CGPoint(x: 300, y: 300))
        //                path.addLine(to: CGPoint(x: 200, y: 100))
        //            }
        //            .stroke(Color.yellow, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
        //        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
