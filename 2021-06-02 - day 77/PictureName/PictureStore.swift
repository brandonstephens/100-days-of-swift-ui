//
//  PictureStore.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/8/21.
//

import Foundation
import SwiftUI

//extension Picture: Codable {
//    enum CodingKeys: CodingKey {
//        case id, title, imageId
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(UUID.self, forKey: .id)
//        title = try container.decode(String.self, forKey: .title)
//        imageId = try container.decode(UUID.self, forKey: .imageId)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//        try container.encode(imageId, forKey: .imageId)
//    }
//}
struct Picture: Identifiable, Codable {
    var id: UUID
    var title: String
    var imageName: String
}

class PictureStore: ObservableObject {    
    @Published var pictures = [Picture]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(pictures) {
                UserDefaults.standard.set(encoded, forKey: "Pictures")
            }
        }
    }
    
    init() {
        if let pictures = UserDefaults.standard.data(forKey: "Pictures") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Picture].self, from: pictures) {
                self.pictures = decoded
                return
            }
        }
        
        self.pictures = []
    }
}
