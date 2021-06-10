//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Brandon Stephens on 4/28/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        Button("Save") {
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 12")
    }
}
