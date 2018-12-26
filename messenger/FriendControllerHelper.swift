//
//  FriendControllerHelper.swift
//  messenger
//
//  Created by C4Q on 12/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import CoreData


extension FriendController {

    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let entityNames = ["Message","Friend"]
            for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         do {
                let  objects = try context.fetch(fetchRequest)
            
                for object in objects {
                    context.delete(object as! NSManagedObject)
                }
               try context.save()
            } catch let err {
                print(err)
            }
        }
        }
    }
    func setupData() {
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
      
       let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context)
            as! Friend
            
        mark.name = "Mark Zuckberg"
        mark.profileImageName = "zuckprofile"
        
        let messageMark = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageMark.friend = mark
        messageMark.text = "Hello, this is mark, nice to meet you..."
            messageMark.date = Date() as NSDate
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "jobsprofile"
        
        let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageSteve.friend = steve
        messageSteve.text = "Hello, this is Steve from Apple, nice to meet you..."
            messageSteve.date = Date() as NSDate
            do {
       try context.save()
            } catch let err {
                print(err)
            }
     //   messages = [messageMark, messageSteve]
        }
        loadData()
        
    }
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            // which return [NSFetchRequestResult]
          
            do {
                messages = try context.fetch(fetchRequest) as? [Message]
            } catch let err {
                print(err)
            }
    }
    }
}
