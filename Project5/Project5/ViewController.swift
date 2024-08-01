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
        let lowerAnswer = answer.lowercased() //make all string lowercase
        if isPossible(word: lowerAnswer){ // run it through 3 methods to ensure words correct
            if isOriginal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    usedWords.insert(answer, at: 0) //insert answer into used words array at position 0 to view it at top
                    
                    let indexPath = IndexPath(row: 0, section: 0) //ask tableView to insert row at top position aka 0
                    //why not just reload since tableView already gets data from usedWords array ? To animate it appearing instead of reload everything with word suddenly there
                    tableView.insertRows(at: [indexPath], with: .automatic) //with describes how it is animated aka slides new row inn from the top
                }
            }
        }
        
    }
    
    func isPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else {return false} //make sure we have title in view and extract it and lowercase it
        
        for letter in word { //loops over all letters in word input by user
            if let position = tempWord.firstIndex(of: letter) { //find first time that letter appears in temp word
                tempWord.remove(at: position) // if letter found remove it from temp word
            }
            else { return false } // if letter not found return false
        }
        return true //if all letters founnd return true
    }
    
    func isOriginal(word:String) -> Bool{
        return !usedWords.contains(word) //not to flip result of contains
    }
    
    func isReal(word:String) -> Bool{ //ui kit class UIKitCheker that spots spelling errors
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count) // tell it to scan at position 0 till end of word using utf16count
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

}

