//
//  Resort.swift
//  SnowSeeker
//
//  Created by Brandon Stephens on 7/8/21.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    let size: Int
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

