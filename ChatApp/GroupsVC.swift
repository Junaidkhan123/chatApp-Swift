//
//  SecondViewController.swift
//  ChatApp
//
//  Created by Junaid Khan on 02/08/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    @IBOutlet weak var groupsTableView: UITableView!
    var groups = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataSerivces.instance.REF_GROUPS.observe(.value, with: { (snapshot) in
     
            DataSerivces.instance.getAllGroups { (returnedArray) in
                self.groups = returnedArray
                self.groupsTableView.reloadData()
            }
            
        })
    }

}
extension GroupsVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell") as?GroupCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(groupTitle: groups[indexPath.row].groupTitle, groupDescription: groups[indexPath.row].groupDesc, groupMembersCount: groups[indexPath.row].grpMembersCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC
            else {return}
        groupFeedVC.initData(forGroup: groups[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
    }
}

