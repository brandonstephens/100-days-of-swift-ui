//
//  DetailView.swift
//  Bookworm
//
//  Created by Brandon Stephens on 4/27/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    let book: Book
    
    func deleteBook() {
        moc.delete(book)
        
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    var formattedDate: String {
        if let date = book.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            
            return formatter.string(from: book.date!)
        } else {
            return "Date missing"
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre != "" ? self.book.genre ?? "" : "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre != "" ? self.book.genre?.uppercased() ?? "" : "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Capsule())
                        .offset(x: -8, y: -8)
                }
                
                Text(self.book.author ?? "Unknown")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No Review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Text(formattedDate)
                    .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown"), displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete book"),
                message: Text("Are you sure?"),
                primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button( action: {
            self.showAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "The Gunslinger"
        book.author = "Stephen King"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "Like a wheel."
        book.date = Date()
        
        return NavigationView {
            DetailView(book: book)
        }.previewDevice("iPhone 12")
    }
}
