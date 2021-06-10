//
//  ContentView.swift
//  Drawing
//
//  Created by Brandon Stephens on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetAmount: CGFloat = 0.75
    @State private var isAdditive = true
    @State private var blurAmount: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(isAdditive ? Color.pink : Color.red)
//                    .fill(Color(hue: 0, saturation: 1, brightness: 1))
                    .frame(width: 240 * offsetAmount)
                    .offset(x: -48, y: -80)
                    .blendMode(isAdditive ? .multiply : .screen)
                
                Circle()
                    .fill(isAdditive ? Color.blue : Color.green)
//                    .fill(Color(hue: 1/3, saturation: 1, brightness: 1))
                    .frame(width: 240 * offsetAmount)
                    .offset(x: 48, y: -80)
                    .blendMode(isAdditive ? .multiply : .screen)
                
                Circle()
                    .fill(isAdditive ? Color.yellow : Color.blue)
//                    .fill(Color(hue: 2/3, saturation: 1, brightness: 1))
                    .frame(width: 240 * offsetAmount)
                    .blendMode(isAdditive ? .multiply : .screen)
            }
            .frame(width: 320, height: 320)
//            .saturation(Double(blurAmount))
//            .blur(radius: (1 - blurAmount) * 24)
            
            Slider(value: $offsetAmount)
                .padding()
            
//            Slider(value: $blurAmount).padding()
            
            Toggle(isOn: $isAdditive, label: {
                Text("Light Mode")
                    .foregroundColor(isAdditive ? .gray : .gray)
            }).padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isAdditive ? Color.white : Color.black)
        .edgesIgnoringSafeArea(.all)
//        Image("cupcakes").colorMultiply(.yellow)
        
//        ZStack {
//            Image("cupcakes")
//
//            Rectangle()
//                .fill(Color.yellow)
//                .blendMode(.softLight)
//                .frame(width: 240, height: 240)
//                .clipped()
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
