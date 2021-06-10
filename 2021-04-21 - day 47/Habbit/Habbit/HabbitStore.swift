//
//  Habbit.swift
//  Habbit
//
//  Created by Brandon Stephens on 4/21/21.
//

import SwiftUI

struct Habbit: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var log: Int = 0
}

class Habbits: ObservableObject {
    @Published var habbits = [Habbit]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habbits) {
                UserDefaults.standard.set(encoded, forKey: "Habbits")
            }
        }
    }
    
    init() {
        if let habbits = UserDefaults.standard.data(forKey: "Habbits") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habbit].self, from: habbits) {
                self.habbits = decoded
            }
        }
        
        self.habbits = []
    }
}

