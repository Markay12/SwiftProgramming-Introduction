//
//  ViewController.swift
//  StoryboardTest
//
//  Created by Mark Ashinhust on 1/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    // labels for the user direction
    @IBOutlet weak var initNameLabel: UILabel!

    @IBOutlet weak var initLastNameLabel: UILabel!
    
    @IBOutlet weak var clickMeButton: UIButton!
    
    // take in user information for name
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    
    // welcome label after button clicked
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //name labels and image
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        
        //load all information and hide what should be shown upon an image clicked
        super.viewDidLoad()
        self.img.isHidden = true
        self.nameLabel.isHidden = true
        self.welcomeLabel.isHidden = true
    }
    
    
    @IBAction func clickMeController(_ sender: Any) {
        
        //set name variables
        let name = self.nameText.text!
        let lastname = self.lastNameText.text!
        
        // print user information
        print(name)
        print(lastname)
        
        //set first name and last name
        self.nameLabel.text = "\(name) \(lastname)"
        
        // change name color to orange
        // my favorite color
        self.nameLabel.textColor = UIColor.orange
        
        // show the labels now they are set
        self.welcomeLabel.isHidden = false
        self.nameLabel.isHidden = false
        
        // set the image and show it upon button being clicked
        self.img.image = UIImage(named: "ArizonaStateImage")
        self.img.isHidden = false
        
        // hide input selections
        self.initNameLabel.isHidden = true
        self.initLastNameLabel.isHidden = true
        self.nameText.isHidden = true
        self.lastNameText.isHidden = true
        self.clickMeButton.isHidden = true
        

    }
    
}

