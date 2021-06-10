//
//  UserStore.swift
//  FriendFace
//
//  Created by Brandon Stephens on 5/1/21.
//

import SwiftUI

struct Response: Codable {
    var results: [User]
}

struct Friend: Codable, Hashable {
    var id: UUID
    var name: String
}

struct User: Codable {
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
    var friends: [Friend]
}

class UserStore: ObservableObject {
    @Published var users = [User]()
    
    init() {
        // referenced this for help
        // https://github.com/alexfresneda/100-Days-Of-SwiftUI/blob/4e723164a29fec3ffb7c8fec6b727d8706a6e23c/FriendsList/FriendsList/Users.swift
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                DispatchQueue.main.async {
                    self.users = decodedUsers
//                    print(self.results)
                }
            } catch let error {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    func findById(id: UUID) -> User? {
        if let user = users.first(where: {$0.id == id}) {
            return user
        }
        
        return users.first
    }
}
