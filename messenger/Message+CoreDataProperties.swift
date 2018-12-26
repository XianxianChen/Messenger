//
//  Message+CoreDataProperties.swift
//  messenger
//
//  Created by C4Q on 12/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var friend: Friend?

}
