//
//  Card.swift
//  Flashzilla
//
//  Created by Brandon Stephens on 6/22/21.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
