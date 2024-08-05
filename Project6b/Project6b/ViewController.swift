//
//  ViewController.swift
//  Project6b
//
//  Created by Hamza Hatem on 05/08/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label1 = UILabel() //UIkit that shows static text
        label1.translatesAutoresizingMaskIntoConstraints = false //make constraints by hand
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit() //make label take as much space as contents
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWSOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1) //show label on screen
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        //running app now makes labels overlap
        
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5] //dictionnary which stores labels and their names as keys
        
        //or do this in a loop
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", metrics: nil, views: viewsDictionary))
        
        for label in viewsDictionary.keys {
            //addConstraints adds array of constraints to view, NSLlayoutConstraint.constraints(withVisualFormat is the autolayout method that converts vfl into array of constraints
            //H:|[\(label)]| this describes how we want layout to look H means horisontal layout, | means edge of view, [] means put label1 here
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|",options: [] ,metrics: nil, views: viewsDictionary))
        }
        
        //V:|[label1]-[label2]-[label3]-[label4]-[label5] the - means space, no | at the end so leaves whitespace after last label
        //(==88) means size must be 88 points
        //(>=10)-| means atleast 10 points space
        //metrics give vfl a set of sizes with names then use these instead of harcoding numbers in each label
        //@999 sets priority less than 1000
        //adding label1 insntead of labelheight means let all labels same height as label1
        let metrics =  ["labelHeight": 88]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|",options: [] ,metrics: metrics, views: viewsDictionary))
        
        //can give layout constraints priority by default all have priority 1000
        
    }
    

}

