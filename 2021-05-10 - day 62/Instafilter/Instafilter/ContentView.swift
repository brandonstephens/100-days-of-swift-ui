//
//  ContentView.swift
//  Instafilter
//
//  Created by Brandon Stephens on 5/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    @State private var bgColor = Color.white
    
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("new value \(blurAmount)")
        }
    }
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            
            set: {
                self.blurAmount = $0
                print("new vlaue is \(self.blurAmount)")
            }
        )
        
        VStack {
            Text("Hello, world!")
                .frame(width: 240, height: 240)
                .background(bgColor)
                .blur(radius: blurAmount)
                .onTapGesture {
                    self.show = true
                }
            
            Slider(value: blur, in: 0...20)
        }
        .actionSheet(isPresented: $show) {
            ActionSheet(title: Text("Change Background"), message: Text("Pick a new color"), buttons: [
                            .default(Text("Red")) {self.bgColor = .red},
                .default(Text("Green")) {self.bgColor = .green},
                .default(Text("Blue")) {self.bgColor = .blue},
                .cancel(),
            ])
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
