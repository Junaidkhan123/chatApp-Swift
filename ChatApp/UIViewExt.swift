//
//  UIViewExt.swift
//  ChatApp
//
//  Created by Junaid Khan on 07/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
extension UIView
{
    func bindToKeyBoard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(mykeyBoardWillChange(_ :)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    func mykeyBoardWillChange(_ notification: NSNotification)
    {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let delta = endFrame.origin.y - beginingFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += delta
        }, completion: nil)
    }
}
