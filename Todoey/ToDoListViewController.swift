//
//  ViewController.swift
//  Todoey
//
//  Created by Korman Chen on 1/16/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    private var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserDefaults()
        tableView.reloadData()
    }
    
    //MARK: Functions
    func loadUserDefaults() {
        if let someList = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = someList
        }
    }
    
    //MARK: Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var usersItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let usersItem = usersItemTextField.text {
                self.itemArray.append(usersItem)
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            usersItemTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

