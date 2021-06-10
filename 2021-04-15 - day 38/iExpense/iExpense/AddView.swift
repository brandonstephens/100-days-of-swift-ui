//
//  AddView.swift
//  iExpense
//
//  Created by Brandon Stephens on 4/14/21.
//

import SwiftUI


struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    static let types = ["Personal", "Business"]

    func validNumber(value: String) -> Bool {
        let castValue = Double(value)
        return castValue != nil ? true : false
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount).keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    guard validNumber(value: self.amount) else {
                        errorTitle = "😯 Amount Error"
                        errorMessage = "Make sure the amount is a number"
                        showError = true
                        return
                    }
                    
                    if let actualAmount = Double(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
            .alert(isPresented: $showError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Try again")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
