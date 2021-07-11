//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Brandon Stephens on 7/9/21.
//

import SwiftUI

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    static let filename = getDocumentsDirectory().appendingPathComponent("data.json")
    
    init() {
        do {
            let data = try Data(contentsOf: Self.filename)
            self.resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            print("Unable to load saved data.")
            self.resorts = []
        }
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
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: Self.filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
