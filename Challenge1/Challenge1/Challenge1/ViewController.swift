//
//  ViewController.swift
//  Challenge1
//
//  Created by Hamza Hatem on 12/08/2024.
//

import UIKit

class ViewController: UITableViewController {
var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //added item add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshShoppingList))
        
        title = "Your shopping list"
        tableView.reloadData()//
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    
    @objc func refreshShoppingList(){
        let ac = UIAlertController(title: "are you sure you want to clear shopping list ?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: clearShoppingList)
        ac.addAction(yesAction)
        present(ac, animated: true)
        }
    
    func clearShoppingList(_: UIAlertAction) -> Void{
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Enter your item to the shopping list", message: nil, preferredStyle: .alert)
        ac.addTextField()// add text field to alert
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default){
            [weak self, weak ac] action in
            guard let shoppingItem = ac?.textFields?[0].text else {return}
            self?.submit(shoppingItem)
        }
        ac.addAction(confirmAction)
        present (ac, animated: true)
    }
    func submit(_ shoppingItem: String){
        shoppingList.insert(shoppingItem, at: 0)
        
        let indexPath = IndexPath(row: 0 , section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }

}

