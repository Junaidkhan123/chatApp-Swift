//
//  GroupFeedVC.swift
//  ChatApp
//
//  Created by Junaid Khan on 10/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {
    @IBOutlet weak var groupFeedTable: UITableView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var sendMessageTF: InsertTextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var groupMessages = [Message]()
    var group : Group?
    func initData(forGroup group: Group)
    {
        self.group = group
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendView.bindToKeyBoard()
        groupFeedTable.delegate = self
        groupFeedTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.groupTitle
        DataSerivces.instance.getEmail(forGroups: group!) { (returnedArray) in
            self.membersLabel.text = returnedArray.joined(separator: ", ")
        }
        
        DataSerivces.instance.REF_GROUPS.observe(.value, with: { (blahblahSnapShot) in
            DataSerivces.instance.getMessagesFor(desiredGroup: self.group!, handler: { (returnedObjetOFMessaegsArray) in
                self.groupMessages = returnedObjetOFMessaegsArray
                self.groupFeedTable.reloadData()
                if self.groupMessages.count > 0
                {
                    self.groupFeedTable.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
            
        })
        
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if sendMessageTF.text != ""
        {
            sendMessageTF.isEnabled = false
            sendBtn.isEnabled = false
            DataSerivces.instance.uploadPosts(withMessage: sendMessageTF.text!, forID: (Auth.auth().currentUser?.uid)!, forGroupKey: group?.groupKey, upLoadComplete: { (isComplete) in
                if isComplete
                {
                    self.sendMessageTF.text = ""
                    self.sendMessageTF.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension GroupFeedVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupFeedTable.dequeueReusableCell(withIdentifier: "GroupFeedCell", for: indexPath)  as? GroupFeedCell
        else
        {
            return UITableViewCell()
        }
        let message = groupMessages[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        DataSerivces.instance.getUserName(forUSerId: message.senderId) { (returnedEmail) in
            cell.configureCell(profileImage: image!, email: returnedEmail, content: message.content)
        }
        return cell
    }
}

