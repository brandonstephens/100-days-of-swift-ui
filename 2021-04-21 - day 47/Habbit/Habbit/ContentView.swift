//
//  ContentView.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/21/21.
//

import SwiftUI

// https://www.hackingwithswift.com/guide/ios-swiftui/4/3/challenge

import SwiftUI

struct ContentView: View {
    @ObservedObject var habbits = Habbits()
    @ObservedObject var viewStore = ViewStore()

    var body: some View {
        NavigationView {
            ListView(habbits: habbits)
                .navigationBarTitle("🐰 Habbit")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            viewStore.showSheet.toggle()
                                        }) {
                                            Text("+ New")
                                        }
                )
        }.sheet(isPresented: $viewStore.showSheet) {
            AddView(habbits: habbits, viewStore: viewStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
