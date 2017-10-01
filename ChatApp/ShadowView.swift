//
//  ShadowView.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
}
