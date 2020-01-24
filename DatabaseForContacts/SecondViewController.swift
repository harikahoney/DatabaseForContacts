//
//  SecondViewController.swift
//  DatabaseForContacts
//
//  Created by Sagi Harika on 16/12/19.
//  Copyright © 2019 Sagi Harika. All rights reserved.
//

import UIKit
import SQLite
class SecondViewController: UIViewController{
    
    var path:String!
    var dbConn:Connection!

   
    var values = [String]()
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var phoneNumTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        firstNameTF.keyboardType = .asciiCapable
        lastNameTF.keyboardType = .asciiCapable
        ageTF.keyboardType = .numberPad
        emailTF.keyboardType = .emailAddress
        phoneNumTF.keyboardType = .namePhonePad
        
        if(ViewController.isContactButtonTapped)
        {
            firstNameTF.text = ViewController.firstName[ViewController.contactButtonTapped]
            
            lastNameTF.text = ViewController.lastName[ViewController.contactButtonTapped]
            
            ageTF.text = ViewController.age[ViewController.contactButtonTapped]
            emailTF.text = ViewController.email[ViewController.contactButtonTapped]
            phoneNumTF.text = ViewController.phoneNum[ViewController.contactButtonTapped]
        }
        
        
        
        
          //getting path and creating database and table
        
         path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        do
        {
            dbConn = try Connection("\(path!)/contactdb.sqlite3")
            print(path!)

            
            try! dbConn.run("create table IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT,FirstName,Lastname,age,email,phonenumber)")
            
        }
        catch
        {
            print("Connection not Established")
        }

        
        
        
        // Do any additional setup after loading the view.
    }
    
    //update query
    @IBAction func saveBtnTap(_ sender: Any)
    {
        
        if(ViewController.isContactButtonTapped)
        {
            
            do
               {
                try dbConn.run("UPDATE CONTACTS SET firstName = '\(firstNameTF.text!)', lastName = '\(lastNameTF.text!)' , age = '\(ageTF.text!)' WHERE phonenumber = '\(phoneNumTF.text!)'")
                print("data updated")
            }
            catch
            {
            print("data not updated")
            }
        }
        else
        {
            do
               {
                try dbConn.run("INSERT INTO CONTACTS(FirstName,Lastname,age,email,phonenumber)values(?,?,?,?,?)",firstNameTF.text!,lastNameTF.text!,ageTF.text!,emailTF.text!,phoneNumTF.text!)
                print("data Inserted")
            }
            catch
            {
            print("data not inserted")
            }
        }
        
        
        
       
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
}

