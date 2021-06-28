//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Brandon Stephens on 6/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { dimension in
                    dimension[.trailing]
                }
            
            Text("This is a longer line")
            
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading){ dimension in
                        CGFloat(position * -10)
                    }
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
        
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//
//            Text("long")
//
//            Text("and")
//                .font(.title)
//
//            Text("propser")
//                .font(.largeTitle)
//        }
//
//        Text("Live long and prosper")
//            .frame(width: 240, height: 240, alignment: .topLeading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 mini")
    }
}
