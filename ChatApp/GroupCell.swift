
//
//  GroupCell.swift
//  ChatApp
//
//  Created by Junaid Khan on 10/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupsMembers: UILabel!
    
    
    
    func configureCell(groupTitle: String, groupDescription: String, groupMembersCount: Int)
    {
        self.groupTitle.text = groupTitle
        self.groupDescription.text = groupDescription
        self.groupsMembers.text = "\(groupMembersCount) members"
    }
}
