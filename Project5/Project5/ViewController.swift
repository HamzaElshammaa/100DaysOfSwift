//
//  ViewController.swift
//  Project5
//
//  Created by Hamza Hatem on 01/08/2024.
//

import UIKit

class ViewController: UITableViewController {
var allWords = [String]()
var usedWords = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //new right bar button item with add symbol to add word
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer)) //calls proptForAnswer
        
        //to load file start.txt
        //loads the file start words
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //trys to read file content thus use a  try? in case did not work
            if let startWords = try? String(contentsOf: startWordsURL) {
                //add words to allWords array seperated by linebreak
                allWords = startWords.components(separatedBy: "\n")
            }
            //if for some reason couldnt read or load the file inn the bundle
            if allWords.isEmpty {
                allWords = ["silkworm"]
            }
            
            startGame()
        }
        
        
        
        
    }
    
    
    func startGame() {
        title = allWords.randomElement() //sets title of view controller to random word
        usedWords.removeAll(keepingCapacity: true) // removes all value sfrom used words array
        tableView.reloadData() //
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]// tableview will show all words users found so far so it will be added to usedWords and appear in tableView
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController( title: "enter answer", message: nil, preferredStyle: .alert) //create new alertController
        ac.addTextField() //add a text field to alert
        
        
        //new tricky stuff
        let submitAction = UIAlertAction(title: "Submit", style: .default){ // use trailing closure syntax rather than passinng a method to it
            [weak self, weak ac] action in // before the in is the parameters of closure, after the in is the body of closure
            //weak self and weak ac since both alert controller and view controller are refrenced inside closure, use weak since it might not exist in future could be nill
            guard let answer = ac?.textFields?[0].text else {return} //reads out the text field at index 0 aka first text field in alert controller
            self?.submit(answer)
            
        }
        ac.addAction(submitAction) //adds action to alert controller
        present(ac, animated: true) //present it on screen
    }

    func submit( _ answer: String) {
        
    }

}

