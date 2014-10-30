//
//  studentTableViewController.swift
//  SycamoreAPI
//
//  Created by Drew Rosenberg on 10/24/14.
//  Copyright (c) 2014 Drew Rosenberg. All rights reserved.
//

import UIKit
import Foundation

class studentTableViewController: UITableViewController, SycamoreDelegate {
    
    @IBOutlet var loginButton: UIBarButtonItem!
    
    let sycamoreConnection = Sycamore()
    
    //MARK: Initialization
    override func viewDidLoad() {
        
        //set sycamoreConnection's delegate
        self.sycamoreConnection.delegate = self

        //if login credentials already exist, then move on to token received
        if sycamoreConnection.loggedIn{
            self.tokenReceived()
        }
    }
    
    //MARK: user actions
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if loginButton.title == "Log In"{
            //tell sycamore to initiate the login process
            sycamoreConnection.request_token()
        
        }else{
            //tell sycamore API to log out, change the button title, and reload the tableView
            sycamoreConnection.logout()
            self.loginButton.title = "Log In"
            self.tableView.reloadData()
        }
    }
    
    //MARK: TableView datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.sycamoreConnection.sycamoreData["Students"]?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        //create the student cell using the tableview prototype
        let thisCell = self.tableView.dequeueReusableCellWithIdentifier("Student") as UITableViewCell?
        
        //get the list of students as an array from the API
        if let studentList = sycamoreConnection.sycamoreData["Students"] as? [AnyObject]{

            //pull this individual student from the array
            if let thisStudent = studentList[indexPath.row] as? [String: AnyObject]{
                
                //change the cell's label to the Student's first name
                thisCell?.textLabel?.text = thisStudent["FirstName"] as? String ?? ""
            }
        }
        return thisCell!
    }
    
    //MARK: SycamoreDelegate
    func sycamoreDataReceived(dataReceived:  String) {
        
        //printing stuff to the console for debug purposes
        println("\n\n\n\(dataReceived) received!!\n\n")
        println("\(self.sycamoreConnection.sycamoreData.count)")

        switch dataReceived{
        
        //if "Me" was received, then get student info
        case "Me":
            self.sycamoreConnection.getStudents()
            
        //If "Students" were received, then load the tableView
        case "Students":
            self.tableView.reloadData()

        //anything else is not expected because it was not requested
        default:
            println("WARNING:  received something that wasn't expected!!")
        }
    }
    
    func tokenReceived(){
        
        //change label
        self.loginButton.title = "Log Out"

        //Since token was received, get user's info
        self.sycamoreConnection.getMe()

    }

}
