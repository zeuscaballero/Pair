//
//  PersonListTableViewController.swift
//  Pair
//
//  Created by zeus on 1/27/17.
//  Copyright © 2017 justzeus. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Contact List", message: "Add a person to contacts", preferredStyle: .alert)
        
        var nameFromTF: UITextField!
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add name"
            nameFromTF = textField
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            guard let newPerson = nameFromTF.text else {return}
            PersonController.sharedController.addName(name: newPerson)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        PersonController.sharedController.randomize()
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.sharedController.persons.count % 2 == 0 {
            return PersonController.sharedController.persons.count / 2
        } else {
            return (PersonController.sharedController.persons.count + 1) / 2
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Group \([section + 1][0])"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.sharedController.pairs[section].count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.sharedController.pairs[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    
    
    
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //           let name = PersonController.sharedController.persons[indexPath.section]
    //            PersonController.sharedController.removeName(name: name)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //    }
    //
    
    //}
    
}

