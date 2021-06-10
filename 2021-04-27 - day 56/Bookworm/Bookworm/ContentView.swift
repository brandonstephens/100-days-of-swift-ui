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
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating).font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown").font(.headline).foregroundColor(book.rating == 1 ? Color.red : Color.black)
                            
                            Text(book.author ?? "Unknown").foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("📚 Bookworm")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
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
    
    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(moc.delete)
            try? moc.save()
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
