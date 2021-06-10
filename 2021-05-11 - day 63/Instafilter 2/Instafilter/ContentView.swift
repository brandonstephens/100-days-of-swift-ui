//
//  ContentView.swift
//  Instafilter
//
//  Created by Brandon Stephens on 5/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showing = false
    
    var body: some View {
        VStack {
          image?
            .resizable()
            .scaledToFit()
            
            Button("Pick image") {
                self.showing = true
            }
        }
        .sheet(isPresented: $showing) {
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
