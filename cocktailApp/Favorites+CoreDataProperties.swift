//
//  Favorites+CoreDataProperties.swift
//  cocktailApp
//
//  Created by Mix174 on 27.08.2021.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var name: String?

}

extension Favorites : Identifiable {

}
