//
//  ViewController.swift
//  Project2
//
//  Created by Hamza Hatem on 21/07/2024.
//

import UIKit

class ViewController: UIViewController {
    //button outlets from interface builder
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    //properties
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //more efficient than appending each seperately
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeraia", "poland", "russia", "spain", "uk", "us"]
        
        //since flages have white and bg is white we added a border of length 1, on retina displays will be 2 px or on retina hd its 3 px
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }


    func askQuestion(action: UIAlertAction! = nil){
        
        //automatically shuffles order of countries
        countries.shuffle()
        
        // this generates the correct answer in range 0 ,1 ,2 corresponnding to buttons 0,1,2
        correctAnswer = Int.random(in: 0...2)
        
        
        //button1.setImage assigns image to button -- will change flag when ask question is called
        //for: .normal describes which state of button will be changed
        button1.setImage(UIImage (named: countries[0]), for: .normal)
        button2.setImage(UIImage (named: countries[1]), for: .normal)
        button3.setImage(UIImage (named: countries[2]), for: .normal)
        
        //adds the uppercased name of country to guess
        title = countries[correctAnswer].uppercased()
        
        
    }
    
    //all 3 buttons calling same method, IBAction is when ib triggers code, sender is UIButton cuz thats what will be calling the method, to know which button was tapped use the "Tag"
    //needs to 3 things
    //1- check if answer is correct
    //2-update score
    //3- show message with new score
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        //checking correct answer
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }
        else{
            title = "Wronng"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        //handler is expecting a closure, but here passing it without () breaks code but it is a shortcut
        //error means to say a method use is fine but it need to accept a UIAlert action parameter
        //adding parameter breaks first call of ask question fixing it is using either\
        //1-set action to nil
        //2- redefine ask question so that it has a default of nil
        ac.addAction(UIAlertAction(title:"Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    
    
}

