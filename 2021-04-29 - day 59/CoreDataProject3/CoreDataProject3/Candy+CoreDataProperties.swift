//
//  Candy+CoreDataProperties.swift
//  CoreDataProject3
//
//  Created by Brandon Stephens on 4/29/21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}

extension Candy : Identifiable {

}
