//
//  ContentView.swift
//  iExpense
//
//  Created by Brandon Stephens on 4/14/21.
//

import SwiftUI

enum magnitude {
    case one
    case ten
    case hundred
    case thousand
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func getMagnitude(_ value: Double) -> magnitude {
        switch value {
        case ...9.0:
                return .one
        case 10.0..<100.0:
                return .ten
        case 100.0..<1000.0:
                return .hundred
        case 1000.0...:
                return .thousand
            default:
                return .one
        }
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
                        
                        Text("$\(item.amount, specifier: "%.2f")")
                            .foregroundColor(
                                getMagnitude(item.amount) == .one
                                    ? .green
                                    : getMagnitude(item.amount) == .ten
                                    ? .yellow
                                    : getMagnitude(item.amount) == .hundred
                                    ? .orange
                                    : .red
                            )
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .listStyle(PlainListStyle())
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
