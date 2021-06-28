//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Brandon Stephens on 6/27/21.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountName) {
            VStack {
                Text("bstephtk421")
                    .alignmentGuide(.midAccountName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                
                Image("bs-emoji")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                
                Text("Brandon Stephens")
                    .alignmentGuide(.midAccountName, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 mini")
    }
}
