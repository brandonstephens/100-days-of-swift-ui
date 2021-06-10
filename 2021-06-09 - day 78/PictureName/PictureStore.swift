//
//  PictureStore.swift
//  PictureName
//
//  Created by Brandon Stephens on 6/8/21.
//

import Foundation
import SwiftUI
import MapKit

struct Picture: Identifiable, Codable {
    var id: UUID
    var title: String
    var imageName: String
    var location: CodableMKPointAnnotation?
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
