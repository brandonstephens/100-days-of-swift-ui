//
//  AddView.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/22/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habbits: Habbits
    @ObservedObject var viewStore: ViewStore
    
    @State private var formTitle = ""
    @State private var formDesc = ""
    
    func submitHabbit() {
        habbits.habbits.append(Habbit(title: self.formTitle, description: self.formDesc))
        self.formTitle = ""
        self.formDesc = ""
        viewStore.showSheet.toggle()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("Title")
                    
                    TextField("title", text: $formTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Group {
                    Text("Description")
                    
                    TextField("desciption", text: $formDesc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    submitHabbit()
                }) {
                    Text("Save")
                }
                .styled()
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .navigationBarTitle("Add a habbit")
            .navigationBarItems(trailing: Button(action: {
                viewStore.showSheet.toggle()
            }) {
                Text("Cancel")
            })
        }
    }
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView()
//    }
//}
