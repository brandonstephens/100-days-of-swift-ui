//
//  CoreDataProject3App.swift
//  CoreDataProject3
//
//  Created by Brandon Stephens on 4/29/21.
//

import SwiftUI

@main
struct CoreDataProject3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
