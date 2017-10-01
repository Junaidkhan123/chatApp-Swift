//
//  GroupFeedCell.swift
//  ChatApp
//
//  Created by Junaid Khan on 10/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contrentLabel: UILabel!
    
    
    func configureCell(profileImage : UIImage, email: String, content: String)
    {
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contrentLabel.text = content
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
