//
//  ViewController.swift
//  personInfoApp
//
//  Created by user on 1/22/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ageInput: UITextField!

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var ssnInput: UITextField!
    
    // create an infoDictionary object that stores the person info
    var personInfoDictionary:infoDictionary = infoDictionary()
    
    @IBOutlet weak var searchedAge: UITextField!
    @IBOutlet weak var searchedName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // calling the search function
    @IBAction func search(_ sender: UIBarButtonItem) {
        /*if let ssn = Int64(self.ssnInput.text!) {
          let p =  personInfoDictionary.search(s: ssn)
            if let x = p {
                self.searchedName.text = x.name!
                self.searchedAge.text = String(x.age!)
            }
        }*/
        
        // show the alert controller with data input text field
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        
        let serachAction = UIAlertAction(title: "Search", style: .default) { (aciton) in
            
            let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty {
                let ssn = Int64(text)!
                let p =  self.personInfoDictionary.search(s: ssn)
                if let x = p {
                    self.searchedName.text = x.name!
                    self.searchedAge.text = String(x.age!)
                    print("In search")
                }else{}
             }
             else {
                   // Alert message will be displayed to th user if there is no input
                   let alert = UIAlertController(title: "Data Input Error", message: "enter ssn to search", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                
            }
        //}
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "enter ssn here"
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    // adding a new record
    @IBAction func addRec(_ sender: UIBarButtonItem) {
        // check if input fields are empty
        if let  ssn = Int64(ssnInput.text!),
            let age = Int16(ageInput.text!),
            let name = nameInput.text
            {
            // create a person record
            //let pRecord =  personRecord(n: name, s:ssn, a: age)
            
            personInfoDictionary.add(name, ssn, age)
            
            // remove data from the text fields
            self.ssnInput.text = ""
            self.ageInput.text = ""
            self.nameInput.text = ""
            
            }else
            {
               // Alert message will be displayed to th user if there is no input
               let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
    
        }
    
    
    @IBAction func deleteRecord(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete", message: "Not Implemented", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
         self.present(alert, animated: true)
        
        
    }
    


}

