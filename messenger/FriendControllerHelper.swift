//
//  FriendControllerHelper.swift
//  messenger
//
//  Created by C4Q on 12/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
class Friend: NSObject {
    var name: String?
    var profileImageName: String?
}
class Message: NSObject {
    var text: String?
    var date: Date?
    var friend: Friend?
}

extension FriendController {
    func setupData() {
        let mark = Friend()
        mark.name = "Mark Zuckberg"
        mark.profileImageName = "zuckprofile"
        
        let messageMark = Message()
        messageMark.friend = mark
        messageMark.text = "Hello, this is mark, nice to meet you..."
        messageMark.date = Date()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "jobsprofile"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Hello, this is Steve from Apple, nice to meet you..."
        messageSteve.date = Date()
  
        messages = [messageMark, messageSteve]
    }
}
