//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Brandon Stephens on 4/23/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderStore
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown")")
                self.confirmationTitle = "Error"
                self.confirmationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown")"
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderStore.self, from: data) {
                self.confirmationTitle = "Thanks"
                self.confirmationMessage = "Your order for \(decodedOrder.order.quantity)x \(OrderStore.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid server response")
            }
        }.resume()
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        
                        self.placeOrder()
                        
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Checkout out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thanks"), message: Text(confirmationMessage), dismissButton: .default(Text("Okay")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderStore())
    }
}
