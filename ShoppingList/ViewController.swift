//
//  ViewController.swift
//  ShoppingList
//
//  Created by Felipe Gil on 2021-06-09.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let emailList = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(emailList))
        let saveList = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveList))
        navigationItem.rightBarButtonItems = [addItem]
        navigationItem.leftBarButtonItems = [saveList, emailList]
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc private func addItem(edit: Bool, index: Int) {
        let alertController = UIAlertController(title: "Enter product", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "submit", style: .default) {
            [weak self, weak alertController] action in
            guard let answer = alertController?.textFields?[0].text else { return }
            
            if edit == true {
                self?.edit(answer, index: index)
            } else {
                self?.submit(answer)
            }
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    private func loadData() {
        #warning("Implement fetch")
    }
    
    @objc private func saveList() {
        #warning("Implement saving to Core Data")
    }
    
    @objc private func emailList() {
        #warning("Implement new function, send list by e-mail")
    }
    
    private func submit(_ answer: String) {
        shoppingList.insert(answer, at: 0)
        let indexPath = IndexPath (row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func edit(_ answer: String, index: Int) {
        shoppingList.insert(answer, at: index)
        let indexPath = IndexPath (row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .destructive, title: "Edit", handler: { (action, view, completion) in
            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.addItem(edit: true, index: indexPath.row)
            completion(true)
        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (action, view, completion) in
            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        })
        deleteAction.backgroundColor = UIColor.red
        
        let config = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Checked", handler: { (action, view, completion) in
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                } else {
                    cell.accessoryType = .checkmark
                }
            }
            completion(true)
        })
        completeAction.backgroundColor = UIColor.systemGreen
        
        let config = UISwipeActionsConfiguration(actions: [completeAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
}
