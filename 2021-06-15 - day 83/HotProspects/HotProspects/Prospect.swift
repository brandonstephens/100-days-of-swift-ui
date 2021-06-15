//
//  Prospect.swift
//  HotProspects
//
//  Created by Brandon Stephens on 6/14/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // make sure to call this 1st
        prospect.isContacted.toggle()
    }
}
