//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Brandon Stephens on 4/23/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        // tk
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Checkout out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
