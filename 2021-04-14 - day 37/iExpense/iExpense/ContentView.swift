//
//  ContentView.swift
//  iExpense
//
//  Created by Brandon Stephens on 4/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            
                            Text(item.type).font(.caption).foregroundColor(item.type == "Personal" ? .gray : .yellow)
                        }
                        
                        Spacer()
                        
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
