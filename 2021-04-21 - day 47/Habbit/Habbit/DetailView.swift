//
//  DetailView.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/22/21.
//

import SwiftUI

struct DetailView: View {
    var habbit: Habbit
    @ObservedObject var habbits: Habbits
    @State var count: Int
    
    init(habbit: Habbit, habbits: Habbits) {
        self.habbit = habbit
        self.habbits = habbits
        _count = State(initialValue: habbit.log)
    }
    
    func handleChange() {
        if let index = habbits.habbits.firstIndex(where: { $0.id == habbit.id }){
            habbits.habbits[index] = Habbit(
                title: habbit.title,
                description: habbit.description,
                log: count
            )
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(spacing: 8) {
                    Text(habbit.title).font(.title)
                    
                    Text(habbit.description).font(.caption)
                }
                    
                Stepper(
                    onIncrement: { count += 1},
                    onDecrement: { count -= 1 }
                ) {
                    Text("Completed: \(count) time\(count == 1 ? "": "s")")
                }
                
                Button(action: {
                    handleChange()
                }, label: {
                    Text("Save")
                })
                .styled()
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    @ObservedObject var habbits = Habbits()
//    
//    static var previews: some View {
//        DetailView(habbit: habbits.habbits[0])
//    }
//}
