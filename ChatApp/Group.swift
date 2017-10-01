//
//  Group.swift
//  ChatApp
//
//  Created by Junaid Khan on 10/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import UIKit
class Group {
    private var _groupTitle:String!
    private var _groupDesc: String!
    private var _groupKey: String!
    private var _grpMembersCount: Int!
    private var _groupMembers: [String]!
    
    var groupTitle : String
    {
        return _groupTitle
    }
    
    var groupDesc : String{
        return _groupDesc
    }
    
    var groupKey: String
    {
        return _groupKey
    }
    
    var grpMembersCount : Int
    {
        return _grpMembersCount
    }
    var groupMembers: [String]
    {
        return _groupMembers
    }
    init(groupTitle : String,groupDesc : String,  groupKey: String, groupMembers: [String], grpMembersCount : Int) {
        self._groupTitle = groupTitle
        self._groupDesc = groupDesc
        self._groupKey = groupKey
        self._groupMembers = groupMembers
        self._grpMembersCount = grpMembersCount

    }
    
}
