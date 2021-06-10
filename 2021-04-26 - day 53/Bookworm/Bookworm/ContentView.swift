//
//  ContentView.swift
//  Bookworm
//
//  Created by Brandon Stephens on 4/26/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var students: FetchedResults<Student>

    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
                .onDelete(perform: deleteStudents)
            }
            
            Button("Add") {
                addItem()
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let firstNames = ["Ginny", "Harry", "Luna", "Ron", "Hermione"]
            let lastNames = ["Potter", "Lovegood", "Weasley", "Granger"]
            
            let chosenFirst = firstNames.randomElement()!
            let chosenLast = lastNames.randomElement()!
            
            let student = Student(context: moc)
            student.id = UUID()
            student.name = "\(chosenFirst) \(chosenLast)"
            

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteStudents(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
