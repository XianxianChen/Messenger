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
        
       createMsg(text: "Hi, this is Mark zuckberg", friend: mark, minutesAge: 3, context: context)
        createSteveMsg(context: context)
        
        let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
       donald.name = "Donald Trump"
        donald.profileImageName = "trumpProfile"
        createMsg(text: "I'm the president Trump, I like trweeting lol", friend: donald, minutesAge: 5, context: context)
     
            
         let ganhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            ganhi.name = "Mohatma Ganhi"
            ganhi.profileImageName = "ganhiProfile"
            createMsg(text: "I'm ganhi, nice to meet you ", friend: ganhi, minutesAge: 60 * 25, context: context)
            
            let gates = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gates.name = "Bill Gates"
            gates.profileImageName = "gatesProfile"
            createMsg(text: "I'm Bill Gates, How are you xian? ", friend: gates, minutesAge: 60 * 24 * 8, context: context)
            do {
       try context.save()
            } catch let err {
                print(err)
            }
     //   messages = [messageMark, messageSteve]
        }
        
        loadData()
        
    }
    func createSteveMsg(context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "jobsprofile"
        createMsg(text: "Hi, this is Steve Jobs from Apple", friend: steve, minutesAge: 19, context: context)
        createMsg(text: "nice to meet you xian", friend: steve, minutesAge: 20, context: context)
        createMsg(text: "Are you interested in buying apple watch? We have a wide variaty of new products that will suit your need. Please let me know what product you are interested?", friend: steve, minutesAge: 18, context: context)
        // response messages
        createMsg(text: "Yes, I want a iPhone XR, Could you give me one for free as new year's gift?", friend: steve, minutesAge: 17, context: context, isSender: true)
        createMsg(text: "totally understand that the iphone 11 will be release in September this year, please wait patiently ", friend: steve, minutesAge: 16, context: context)
        createMsg(text: "Absolutely, just that my iphone 6 is kinda old, I want to update to the newest iphone ", friend: steve, minutesAge: 5, context: context, isSender: true)
        
    }
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            // fetch all friends
            if let friends = fetchFriends() {
                messages = [Message]()
            for friend in friends {
                print(friend.name!)
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                // which return [NSFetchRequestResult]
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                
                do {
                  let fetchedMsg = try context.fetch(fetchRequest) as! [Message]
                      messages?.append(contentsOf: fetchedMsg)
                    // not  context.execute(fetchRequest) as? [Friend]
                    // Cast from 'NSPersistentStoreResult' to unrelated type '[Friend]' always fails
                } catch let err {
                    print(err)
                }
                }
               messages?.sort(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
            
    }
        }
    }
    
    func createMsg(text: String, friend: Friend, minutesAge: Double, context: NSManagedObjectContext, isSender: Bool = false) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAge * 60) as NSDate
        message.isSender = isSender
    }
    
   private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
    if let context = delegate?.persistentContainer.viewContext {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        do {
           return try context.fetch(fetchRequest) as? [Friend]
        } catch let err {
            print(err)
        }
 
    }
    return nil
    }
}
