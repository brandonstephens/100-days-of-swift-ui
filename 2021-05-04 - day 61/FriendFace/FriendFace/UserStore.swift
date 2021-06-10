//
//  UserStore.swift
//  FriendFace
//
//  Created by Brandon Stephens on 5/1/21.
//

import SwiftUI

struct Response: Codable {
    var results: [UserData]
}

struct FriendData: Codable, Hashable {
    var id: UUID
    var name: String
}

struct UserData: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [FriendData]
}
