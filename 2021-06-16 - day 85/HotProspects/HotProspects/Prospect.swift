//
//  Prospect.swift
//  HotProspects
//
//  Created by Brandon Stephens on 6/14/21.
//

import SwiftUI

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let filename = getDocumentsDirectory().appendingPathComponent("data.json")
    
    init() {
        do {
            let data = try Data(contentsOf: Self.filename)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Unable to load saved data.")
            self.people = []
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: Self.filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // make sure to call this 1st
        prospect.isContacted.toggle()
        save()
    }
}
