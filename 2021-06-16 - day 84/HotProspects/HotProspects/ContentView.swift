//
//  ContentView.swift
//  HotProspects
//
//  Created by Brandon Stephens on 6/9/21.
//

import SwiftUI

struct ContentView: View {
    var propsects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none).tabItem{
                Image(systemName: "person.3")
                Text("Everyone")
            }
            
            ProspectsView(filter: .contacted).tabItem{
                Image(systemName: "checkmark.circle")
                Text("Contacted")
            }
            
            ProspectsView(filter: .uncontacted).tabItem{
                Image(systemName: "questionmark.diamond")
                Text("Uncontacted")
            }
            
            MeView().tabItem{
                Image(systemName: "person.crop.square")
                Text("Me")
            }
        }
        .environmentObject(propsects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
