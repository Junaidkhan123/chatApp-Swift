//
//  LoginVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
class LoginVC: UIViewController {

    @IBOutlet weak var emailField: InsertTextField!
    @IBOutlet weak var passwordField: InsertTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func singBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil
        {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (sucsess, loginError) in
                if sucsess
                {
                    self.dismiss(animated: true, completion: nil)
                }
                else
                {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, registrationComplete: { (success, registrationError) in
                    if success
                    {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        self.dismiss(animated: true, completion: nil)
                    }
                    else
                    {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
            })
        }
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension LoginVC: UITextFieldDelegate
{
    
}
