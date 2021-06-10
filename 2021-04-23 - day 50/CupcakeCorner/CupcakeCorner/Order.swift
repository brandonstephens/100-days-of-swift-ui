//
//  Order.swift
//  CupcakeCorner
//
//  Created by Brandon Stephens on 4/23/21.
//

import Foundation

class Order: ObservableObject {
    static let types = [
        "Vanilla",
        "Strawberry",
        "Chocolate",
        "Superman"
    ]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestsEnabled = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var street = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddr: Bool {
        if name.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
