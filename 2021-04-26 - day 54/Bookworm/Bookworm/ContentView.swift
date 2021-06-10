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

    @FetchRequest(sortDescriptors: [])
    private var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: Text(book.title ?? "Unknown")) {
                        EmojiRatingView(rating: book.rating).font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown").font(.headline)
                            
                            Text(book.author ?? "Unknown").foregroundColor(.secondary)
                        }
                    }
                }
            }
                .navigationBarTitle("📚 Bookworm")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
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
