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
    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "universe in %@", ["Alien", "Star Wars"])
    ) var ships: FetchedResults<Ship>
    
    @State var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add zamples") {
                let jimi  = Singer(context: viewContext)
                jimi.firstName = "Jimi"
                jimi.lastName = "Hendrix"
                
                let axl = Singer(context: viewContext)
                axl.firstName = "Axl"
                axl.lastName = "Rose"
                
                let adele = Singer(context: viewContext)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.viewContext.save()
            }
            
            Button("Show A's") {
                self.lastNameFilter = "A"
            }
            
            Button("Show H's") {
                self.lastNameFilter = "H"
            }
        }
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown")
//            }
//
//            Button("Add Zamples") {
//                let ship1 = Ship(context: viewContext)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: viewContext)
//                ship2.name = "Millennium Falcon"
//                ship2.universe = "Star Wars"
//
//                let ship3 = Ship(context: viewContext)
//                ship3.name = "Nostromo"
//                ship3.universe = "Alien"
//
//                let ship4 = Ship(context: viewContext)
//                ship4.name = "Defiant"
//                ship4.universe = "Star Trek"
//
//                try? self.viewContext.save()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 12")
    }
}
