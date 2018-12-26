//
//  Friend+CoreDataProperties.swift
//  messenger
//
//  Created by C4Q on 12/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImageName: String?
    @NSManaged public var messages: Message?

}

// MARK: Generated accessors for relationship
extension Friend {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Message)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Message)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
