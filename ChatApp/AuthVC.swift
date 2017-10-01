//
//  AuthVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKShareKit
class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil
        {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func loginFbBtnWasPressed(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            guard let accessToken = FBSDKAccessToken.current()
                else {
                    print("Token Error")
                    return}
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error
                {
                    print("facebbok Error")
                    return 
                }
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    
    @IBAction func loginGoogleBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func loginSignBtnWasPressed(_ sender: Any) {
        let loginVC  = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    
}
