
//
//  UserCell.swift
//  ChatApp
//
//  Created by Junaid Khan on 09/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var checkMarkImage: UIImageView!
    var showing = false
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool)
    {
        self.profileImage.image = image
        self.userEmailLabel.text = email
        if isSelected{
            self.checkMarkImage.isHidden = false
        }
        else
        {
            self.checkMarkImage.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false
            {
                checkMarkImage.isHidden = false
                showing = true
            }
        }
        else {
            checkMarkImage.isHidden = true
            showing = true
        }
    }
    
}
