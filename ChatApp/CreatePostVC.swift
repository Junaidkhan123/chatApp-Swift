
//
//  CreatePostVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 07/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyBoard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != "" &&  textView.text != "Say something here..."
        {
            sendBtn.isEnabled = false
            DataSerivces.instance.uploadPosts(withMessage: textView.text, forID: (Auth.auth().currentUser?.uid)!, forGroupKey: nil, upLoadComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }
                else
                {
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension CreatePostVC: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.text = ""
    }
}






