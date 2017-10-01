//
//  CreateGroupVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 09/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupVC: UIViewController {
    @IBOutlet weak var titleTF: InsertTextField!
    @IBOutlet weak var groupDesTF: InsertTextField!
    @IBOutlet weak var SearchTF: InsertTextField!
    @IBOutlet weak var addedGroupMemberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    var allsearchedEmails = [String]()
    var chooseArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        SearchTF.delegate = self
        SearchTF.addTarget(self, action: #selector(mytextFieldDidChange), for: .editingChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    func mytextFieldDidChange()
    {
        if SearchTF.text == ""
        {
            allsearchedEmails = []
            tableView.reloadData()
        }
        else
        {
            DataSerivces.instance.searchEmailsForGroups(forSearchquery: SearchTF.text!, handler: { (returnedArray) in
                self.allsearchedEmails = returnedArray
                self.tableView.reloadData()
            })
        }
    }
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTF.text != "" && groupDesTF.text != ""
        {
            DataSerivces.instance.getIds(foruserName: chooseArray, handler: { (idsArray) in
                var tempArray = idsArray
                tempArray.append((Auth.auth().currentUser?.uid)!)
                
                DataSerivces.instance.createGroups(withTitle: self.titleTF.text!, andDescription: self.groupDesTF.text!, forUserIds: tempArray, handler: { (success) in
                    if success{
                        let popupAlert = UIAlertController(title: "Congrats🤗🤗!!!", message: "Group Successfully  Created!!!", preferredStyle: .alert)
                       let myAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                       })
                    popupAlert.addAction(myAction)
                    self.present(popupAlert, animated: true, completion: nil)
                    }
                    else
                    {
                        let popupAlert = UIAlertController(title: "Sorry 😔😔", message: "Group cannot be  Created", preferredStyle: .alert)
                        popupAlert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                        self.present(popupAlert, animated: true, completion: nil)
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension CreateGroupVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allsearchedEmails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        if chooseArray.contains(allsearchedEmails[indexPath.row])
        {
            cell.configureCell(profileImage: profileImage!, email: allsearchedEmails[indexPath.row], isSelected: true)
        }
        else
        {
            cell.configureCell(profileImage: profileImage!, email: allsearchedEmails[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell
            else {return}
        if !chooseArray.contains(cell.userEmailLabel.text!)
        {
            chooseArray.append(cell.userEmailLabel.text!)
            addedGroupMemberLabel.text = chooseArray.joined(separator: " ,")
            doneBtn.isHidden = false
        }
        else
        {
            chooseArray = chooseArray.filter({$0 != cell.userEmailLabel.text!})
            if chooseArray.count >= 1
            {
                addedGroupMemberLabel.text = chooseArray.joined(separator: " ,")
            }
            else
            {
                addedGroupMemberLabel.text = "ADD PEOPLE"
                doneBtn.isHidden = true
            }
        }
        
    }
}
extension CreateGroupVC: UITextFieldDelegate{
    
}
