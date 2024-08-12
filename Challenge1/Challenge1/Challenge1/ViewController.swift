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

