//
//  Order.swift
//  CupcakeCorner
//
//  Created by Brandon Stephens on 4/23/21.
//

import Foundation

class OrderStore: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case order
    }
    
    @Published var order = Order()
    
    static let types = [
        "Vanilla",
        "Strawberry",
        "Chocolate",
        "Superman"
    ]
    
    struct Order: Codable {
        var type = 0
        var quantity = 3
        
        var specialRequestsEnabled = false {
            didSet {
                if specialRequestsEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var street = ""
        var city = ""
        var zip = ""
        
        var hasValidAddr: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                street.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(Order.self, forKey: .order)
    }
    
    init () { }
}
