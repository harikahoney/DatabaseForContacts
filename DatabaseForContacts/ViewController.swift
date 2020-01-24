//
//  ViewController.swift
//  DatabaseForContacts
//
//  Created by Sagi Harika on 16/12/19.
//  Copyright © 2019 Sagi Harika. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {
    //declaration of variables
   var path:String!
    var dbConn:Connection!
    
    var allContactButton = [UIButton]()
    var allButtons = [UIButton]()
    
    static var firstName = [String]()
    static var lastName = [String]()
    static var age = [String]()
    static var email = [String]()
    static var phoneNum = [String]()
    static var id = [Int]()
    
    static var isContactButtonTapped = false
   
    static var contactButtonTapped:Int!
    
    @IBOutlet weak var stackViewOne: UIStackView!
    
    @IBOutlet weak var stackViewTwo: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewOne.spacing = 30
        stackViewTwo.spacing = 30
        
        connectToDb()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
//conenction for database
    func connectToDb()
    {
        path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        do
        {
            dbConn = try Connection("\(path!)/contactdb.sqlite3")
            print(path!)
        }
        catch
        {
            print("not connected to database")
        }
        
    }
    
    //displaying and fetching data
    override func viewWillAppear(_ animated: Bool)
    {
        
        
            do
                {
                 let x =  try dbConn.run("select * from CONTACTS")
                    for (i,row) in x.enumerated()
                   {
                    var text = String()
                    
                    for(index,name) in x.columnNames.enumerated()
                       {
                           print("\(name):\(row[index]!)")
                            
                            
                        
                            if(name == "FirstName")
                            {
                                ViewController.firstName.append(row[index]! as! String)
                                
                                text = (row[index]! as! String)
                            }
                            else if(name == "Lastname")
                            {
                                ViewController.lastName.append(row[index]! as! String)
                                
                                text += "  " + (row[index]! as! String)
                             }
                            else if(name == "phonenumber")
                            {
                                text += "\n" + (row[index]! as! String)
                                
                                ViewController.phoneNum.append(row[index]! as! String)
                            }
                        else if(name == "email")
                            {
                                text += "\n" + (row[index]! as! String)
                                ViewController.email.append(row[index]! as! String)
                        }
                        else if(name == "age")
                            {
                                 text += "\n" + (row[index]! as! String)
                                ViewController.age.append(row[index]! as! String)
                        }
                        else if(name == "ID")
                        {
                            ViewController.id.append(Int(row[index]! as! Int64))
                        }
                        
                            }
                    
                    //button for details and update
                   let contactButton = UIButton()
                    contactButton.setTitle(text, for: UIControl.State.normal)
                   contactButton.backgroundColor = UIColor.white
                    contactButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                    contactButton.titleLabel!.numberOfLines = 0
                    contactButton.addTarget(self, action: #selector(contactButtonTap(button:)), for: UIControl.Event.touchUpInside)
                    contactButton.tag = i
                    
                    contactButton.translatesAutoresizingMaskIntoConstraints = false
                   contactButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
                   allContactButton.append(contactButton)
                   stackViewOne.addArrangedSubview(contactButton)
                    
                    //delete button
                    let button = UIButton()
                    button.titleLabel?.numberOfLines = 0
                    button.tag = i
                    button.setTitle("Delete", for: UIControl.State.normal)
                    button.layer.cornerRadius = 80
                    button.setTitleColor(UIColor.black, for: UIControl.State.normal)
                    button.backgroundColor = UIColor.green
                    button.addTarget(self, action: #selector(button_tap), for: UIControl.Event.touchUpInside)
                    
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.heightAnchor.constraint(equalToConstant: 90).isActive = true
                    
                    
                   
                    allButtons.append(button)
                  
                    stackViewTwo.addArrangedSubview(button)
                    

                   
                    
                   }
                    
                    

                    
                    
                }
               catch
               {
                   print("not connected")
               }
        
       
        
               
    }
    
    //update button Event handler
    @objc func contactButtonTap(button:UIButton)
    {
        
        ViewController.isContactButtonTapped = true
        
        ViewController.contactButtonTapped = button.tag
        
        let targetVC = self.storyboard?.instantiateViewController(identifier: "second") as! SecondViewController
        
        for (button1,button2) in zip(allButtons,allContactButton)
        {
            button1.removeFromSuperview()
            
            button2.removeFromSuperview()
        }
        
        
        allContactButton = [UIButton]()
        allButtons = [UIButton]()
        
        
        
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    //delete button event handler
       @objc func button_tap(button:UIButton)
          {
            
            button.removeFromSuperview()
            
            allContactButton[button.tag].removeFromSuperview()
            
            
            allContactButton.remove(at: button.tag)
            
            
            
            do
            {
               //let query = "DELETE FROM CONTACTS"
                let query = "DELETE FROM CONTACTS WHERE ID = \(ViewController.id[button.tag])"
                               
                
                try dbConn.run(query)
                
                
                print(query)
             }
            catch
            {
                print("data not deleted")
            }
         }
    
    
    
    
    //add contact button
                                                                                                
@IBAction func addCntctBtn(_ sender: Any) {
   
    for (l,b) in zip(allContactButton,allButtons)
    {
        l.removeFromSuperview()
        
        b.removeFromSuperview()
    }
    
    allButtons = [UIButton]()
    
    allContactButton = [UIButton]()
    
    let svc = storyboard?.instantiateViewController(withIdentifier: "second") as! SecondViewController
    
    navigationController?.pushViewController(svc, animated: true)
    }
    
    
    
    
    
    
    
    
    }
    


