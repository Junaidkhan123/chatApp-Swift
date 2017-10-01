
//
//  InsertTextField.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class InsertTextField: UITextField {
    override func awakeFromNib() {
        let attrs = [NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: attrs)
        self.attributedPlaceholder =  placeHolder
        super.awakeFromNib()
    }
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
