//
//  AuthService.swift
//  ChatApp
//
//  Created by Junaid Khan on 03/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import Firebase
class AuthService
{
    static let instance = AuthService()
    func registerUser(withEmail email : String, andPassword password: String, registrationComplete: @escaping (_ status: Bool, _ error: Error?)->())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user
            else {
                registrationComplete(false,error)
                return
            }
            let userData = ["provider": user.providerID, "email": user.email]
            DataSerivces.instance.createUser(uid: user.uid, userData: userData)
            registrationComplete(true,nil)
        }
    }
    
    
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status : Bool, _ error : Error?)->())
    {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil
            {
                loginComplete(false, error)
            }
            else
            {
                loginComplete(true,nil)
            }
            
            
            
        }
    }
}
