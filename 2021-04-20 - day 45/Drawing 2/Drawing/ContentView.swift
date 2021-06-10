//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct Trapezoid: Shape {
    var inset: CGFloat
    
    var animatableData: CGFloat {
        get { inset }
        set { self.inset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: inset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct CheckerBoard: Shape {
    var rows: Int
    var cols: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(cols))
        }
        set {
            self.rows = Int(newValue.first)
            self.cols = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let colSize = rect.width / CGFloat(cols)
        
        for row in 0..<rows {
            for col in 0..<cols {
                if (row + col).isMultiple(of: 2) {
                    let startX = colSize * CGFloat(col)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: colSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct ContentView: View {
//    @State private var inset: CGFloat = 48
    @State private var rows = 4
    @State private var cols = 4
    
    var body: some View {
        CheckerBoard(rows: rows, cols: cols)
            .onTapGesture {
                withAnimation(.linear(duration: 1)) {
                    self.rows = 8
                    self.cols = 16
                }
            }
        
//        Trapezoid(inset: inset)
//            .fill(Color.yellow)
//            .frame(width: 240, height: 160, alignment: .center)
//            .onTapGesture {
//                withAnimation {
//                    self.inset = CGFloat.random(in: 0...240)
//                }
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
