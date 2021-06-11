//
//  ContentView.swift
//  HotProspects
//
//  Created by Brandon Stephens on 6/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            
            Text("Change color")
                .padding()
                .contextMenu{
                    Button(action: {
                        self.backgroundColor = .red
                    }, label: {
                        Text("🔴 Red")
                    })
                    
                    Button(action: {
                        self.backgroundColor = .green
                    }, label: {
                        Text("🟢 Green")
                    })
                    
                    Button(action: {
                        self.backgroundColor = .blue
                    }, label: {
                        Text("🔵 Blue")
                    })
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
