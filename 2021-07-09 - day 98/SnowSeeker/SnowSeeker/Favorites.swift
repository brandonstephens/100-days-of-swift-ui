//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Brandon Stephens on 7/9/21.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        // todo load saved data
        
        self.resorts = []
    }
    
    func contains(_ resort: Resort ) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resrot: Resort) {
        objectWillChange.send()
        resorts.insert(resrot.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // todo write out data
    }
}
