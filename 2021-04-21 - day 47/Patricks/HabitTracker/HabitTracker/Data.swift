//
//  Data.swift
//  HabitTracker
//
//  Created by Patrick Hill on 4/7/21.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String = ""
    var completed: Int = 0
}

class Activities: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    func appendActivity(title: String, description: String, completed: Int) {
        self.activities.append(
            Activity(
                title:title,
                description:description,
                completed: completed
            )
        )
    }
    
    init() {

        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            
            if let decode = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decode
                return
            }
        }
        
        // if no user data exists, load a placeholder item
        self.activities = [
            Activity(id: UUID(), title: "Test Activity 1", description: "This is placeholder content so we can see at least one activity", completed: 3)
        ]
    }
}
