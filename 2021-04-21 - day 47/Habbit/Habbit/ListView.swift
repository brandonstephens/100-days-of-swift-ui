//
//  ListView.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/22/21.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var habbits: Habbits
        
    var body: some View {
        VStack {
            if habbits.habbits.isEmpty == true {
                VStack(spacing: 16) {
                    Text("No habbits yet…").font(.largeTitle).foregroundColor(.gray)
                    
                    Image(systemName: "square.dashed").font(.largeTitle).foregroundColor(.gray)
                }
            } else {
                List {
                    ForEach(habbits.habbits) { habbit in
                        NavigationLink(destination: DetailView(habbit: habbit, habbits: habbits)) {
                            Text(habbit.title)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
