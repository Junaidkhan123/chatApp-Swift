
//
//  FeedCell.swift
//  ChatApp
//
//  Created by Junaid Khan on 08/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    func configureCell(profileImage: UIImage, email : String, content: String)
    {
        self.profileImage.image = profileImage
        self.userEmail.text = email
        self.messageContent.text = content
    }
}
