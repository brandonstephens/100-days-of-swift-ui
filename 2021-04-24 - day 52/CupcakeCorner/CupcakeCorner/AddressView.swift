//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Brandon Stephens on 4/23/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderStore
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.street)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
                .disabled(order.order.hasValidAddr == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderStore())
    }
}
