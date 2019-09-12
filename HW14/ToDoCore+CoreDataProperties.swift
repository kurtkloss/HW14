//
//  ToDoCore+CoreDataProperties.swift
//  HW14
//
//  Created by Oleg Shashkov on 12/09/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoCore> {
        return NSFetchRequest<ToDoCore>(entityName: "ToDoCore")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var toDo: String?

}
