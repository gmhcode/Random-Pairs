//
//  GroupsTableViewController.swift
//  Six Week Technical Challenge
//
//  Created by Greg Hughes on 1/11/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupController.shared.createGroups()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return GroupController.shared.groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let group = GroupController.shared.groups[indexPath.section]
        let person = group.personList[indexPath.row]
        cell.textLabel?.text = person

        return cell
    }
   

   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           let group = GroupController.shared.groups[indexPath.section]

            let personToDelete = group.personList[indexPath.row]
            GroupController.shared.delete(person: personToDelete)
            GroupController.shared.createGroups()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
       override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Group \(section + 1)"
        }
    
    
    @IBAction func shuffleGroupsButtonTapped(_ sender: Any) {
        GroupController.shared.shuffle()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addPersonButtonTapped(_ sender: Any) {
        addAlert()
        
    }
    
    
    
    
    
    func addAlert(){
        let alertController = UIAlertController(title: "Add Person", message: "type the name of the person you want to add", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "add person here"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let newPerson = alertController.textFields?[0].text else {return}
            GroupController.shared.createPerson(person: newPerson)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true)
    }
}
