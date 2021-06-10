//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Brandon Stephens on 4/29/21.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    let content: (T) -> Content
    
    init(
        filterKey: String,
        filterValue: String,
        filters: [NSSortDescriptor],
        comparison: comparison,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        
        var comparisonString = ""
        
        switch comparison {
        case .beginsWith:
            comparisonString = "BEGINSWITH"
        case .equals:
            comparisonString = "="
        }
        
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: filters,
            predicate: NSPredicate(format: "%K \(comparisonString) %@ ", filterKey, filterValue)
        )
        self.content = content
    }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            self.content(singer)
        }
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
