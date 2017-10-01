//
//  DataSerivces.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import Firebase
let DB_BASE = Database.database().reference()
class DataSerivces
{
    static let instance = DataSerivces()
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEEDS = DB_BASE.child("feeds")
    
    var REF_BASE : DatabaseReference
    {
        return _REF_BASE
    }
    var REF_USERS : DatabaseReference
    {
        return _REF_USERS
    }
    var REF_GROUPS : DatabaseReference
    {
        return _REF_GROUPS
    }
    var  REF_FEEDS : DatabaseReference
    {
        return _REF_FEEDS
    }
    
    
    func createUser(uid: String, userData: Dictionary<String, Any>)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    func uploadPosts(withMessage message: String , forID uid: String , forGroupKey groupKey: String?, upLoadComplete: @escaping(_ status : Bool)->())
    {
        if groupKey != nil
        {
            // will post to the group
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "sender": uid])
            upLoadComplete(true)
        }
        else
        {
            _REF_FEEDS.childByAutoId().updateChildValues(["content": message, "sender": uid])
            upLoadComplete(true)
        }
    }
    
    func getAllpostsFeeds(handler: @escaping (_ messages: [Message])->())
    {
        var messageArray = [Message]()
        REF_FEEDS.observeSingleEvent(of: .value, with: { (feedMessagesSnapShot) in
            guard let feedMessagesSnapShot = feedMessagesSnapShot.children.allObjects as?[DataSnapshot]
                else {return}
            for eachMessage in feedMessagesSnapShot
            {
                let content = eachMessage.childSnapshot(forPath: "content").value as! String
                let senderId = eachMessage.childSnapshot(forPath: "sender").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        })
        
    }
    func getMessagesFor(desiredGroup: Group , handler: @escaping (_ messagesArray: [Message])->())
    {
        var groupMessages = [Message]()
        REF_GROUPS.child(desiredGroup.groupKey).child("messages").observeSingleEvent(of: .value, with: { (groupMessagesSnapShot) in
            guard let groupMessagesSnapShot = groupMessagesSnapShot.children.allObjects as? [DataSnapshot]
                else {return}
            for eachMessage in groupMessagesSnapShot
            {
                let content = eachMessage.childSnapshot(forPath: "content").value as! String
                let senderId = eachMessage.childSnapshot(forPath: "sender").value as! String
                let message = Message(content: content, senderId: senderId)
                groupMessages.append(message)
            }
            handler(groupMessages)
        })
    }
    
    func getUserName(forUSerId uid: String, handler: @escaping (_ userName: String)->())
    {
        REF_USERS.observeSingleEvent(of: .value, with: { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot]
                else {return}
            for eachUser in userSnapShot
            {
                if eachUser.key == uid
                {
                    handler(eachUser.childSnapshot(forPath: "email").value as! String)
                }
            }
        })
    }
    
    func searchEmailsForGroups(forSearchquery query: String, handler: @escaping (_ emailArray: [String])->())
    {
        var usersEmailArray = [String]()
        REF_USERS.observe(.value, with: { (usersEmail) in
            guard let usersEmail = usersEmail.children.allObjects as? [DataSnapshot]
                else {return}
            for EachUserEamil in usersEmail
            {
                let firebaseEmail = EachUserEamil.childSnapshot(forPath: "email").value as? String
                if firebaseEmail?.contains(query) == true && Auth.auth().currentUser != nil
                {
                    usersEmailArray.append(firebaseEmail!)
                }
            }
            handler(usersEmailArray)
        })
        
    }
    
    func getIds(foruserName  userEmails:[String], handler: @escaping (_ uidsArray:[String])->())
    {
        var idsArray = [String]()
        REF_USERS.observeSingleEvent(of: .value, with: { (userIdFromFireBase) in
            guard let userIdFromFireBase = userIdFromFireBase.children.allObjects as? [DataSnapshot]
                else {return}
            for EachUser in userIdFromFireBase
            {
                let email = EachUser.childSnapshot(forPath: "email").value as? String
                if userEmails.contains(email!)
                {
                    idsArray.append(EachUser.key)
                }
            }
            handler(idsArray)
        })
        
    }
    
    func createGroups(withTitle title : String, andDescription description: String, forUserIds userId:[String], handler: @escaping (_ groupCreationComplete: Bool)->())
    {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": userId])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping(_ groupArry : [Group])->())
    {
        var AllGroups = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value, with: { (groupsSnapShot) in
            guard let groupsSnapShot = groupsSnapShot.children.allObjects as? [DataSnapshot]
                else {return }
            for eachGroup in groupsSnapShot
            {
                let membersArray = eachGroup.childSnapshot(forPath: "members").value as! [String]
                if membersArray.contains((Auth.auth().currentUser?.uid)!)
                {
                    let title = eachGroup.childSnapshot(forPath: "title").value as! String
                    let desc = eachGroup.childSnapshot(forPath: "description").value as! String
                    let group = Group(groupTitle: title, groupDesc: desc, groupKey: eachGroup.key, groupMembers: membersArray, grpMembersCount: membersArray.count)
                    AllGroups.append(group)
                }
            }
            handler(AllGroups)
        })
    }
    func getEmail(forGroups group: Group, handler: @escaping (_ emails: [String])->())
    {
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value, with: { (userEmailsSnapShot) in
           guard let userEmailsSnapShot = userEmailsSnapShot.children.allObjects as? [DataSnapshot]
            else {return}
            for eachUser in userEmailsSnapShot
            {
                if group.groupMembers.contains(eachUser.key)
                {
                    let email = eachUser.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        })
    }

}
