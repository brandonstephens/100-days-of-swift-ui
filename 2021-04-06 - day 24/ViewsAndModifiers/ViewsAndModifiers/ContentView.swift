//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Brandon Stephens on 4/5/21.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct Title: ViewModifier {
    let font = Font.system(.title).weight(.semibold)

    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(font)
    }
}

extension Text {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Lalala").modifier(Title())
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).square.fill").foregroundColor(.black)
                    Text("\(row),\(col)").font(Font.system(.caption, design: .monospaced))
                }.padding(8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
