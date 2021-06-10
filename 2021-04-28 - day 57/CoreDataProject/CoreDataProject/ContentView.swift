//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Brandon Stephens on 4/28/21.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [], animation: .default)
    private var wizards: FetchedResults<Wizard>

    let students = [Student(name: "Harry"), Student(name: "Hermione")]
    
    var body: some View {
        VStack {
            List {
//                ForEach([2,4,6,8,10], id: \.self) {
//                    Text("\($0) is even")
//                }
                
                ForEach(students, id: \.self) { student in
                    Text(student.name)
                }
            }
            
            List {
                ForEach(wizards, id: \.self) { wizard in
                    Text("\(wizard.name ?? "unknown")")
                }
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.viewContext)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Wizard(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 12")
    }
}
