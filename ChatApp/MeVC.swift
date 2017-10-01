//
//  MeVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 07/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
class MeVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var meTableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }

    @IBAction func signoutBtnWasPressed(_ sender: Any) {
        let popupAlert = UIAlertController(title: "Logout?", message: "Do you want to log out ?", preferredStyle: .actionSheet)
        let popUpAction = UIAlertAction(title: "LogOut?", style: .destructive) { (buttonPressed) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                self.present(authVC, animated: true, completion: nil)
            }
            catch
            {
                print(error)
            }
        }
        popupAlert.addAction(popUpAction)
        popupAlert.addAction(UIAlertAction(title: "NO?", style:.destructive , handler: nil))
        present(popupAlert, animated: true, completion: nil)
    }
}
