//
//  FirstViewController.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var allMessagesArray = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataSerivces.instance.getAllpostsFeeds { (returnedMessagesArray) in
            self.allMessagesArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func composeBtnWasPressed(_ sender: Any) {
        let createPostVC = storyboard?.instantiateViewController(withIdentifier: "CreatePostVC") as! CreatePostVC
        present(createPostVC, animated: true, completion: nil)
    }

}
extension FeedVC: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessagesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell
            else {return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let messgaeObject = allMessagesArray[indexPath.row]
        DataSerivces.instance.getUserName(forUSerId: messgaeObject.senderId) { (returnedUserName) in
            cell.configureCell(profileImage: image!, email: returnedUserName, content: messgaeObject.content)
        }
        
        return cell
    }
}
