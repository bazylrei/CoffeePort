//
//  Burger+CoreDataProperties.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Burger {

    @NSManaged var bitcoin: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var image: String?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var promoted: NSNumber?
    @NSManaged var vegetarian: NSNumber?

}
