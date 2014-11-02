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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let sycamoreConnection = Sycamore()
    
    var students = [[String : AnyObject]]()
    
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
            self.students.removeAll(keepCapacity: true)
            self.tableView.reloadData()
        }
    }
    
    //MARK: TableView datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.students.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        //create the student cell using the tableview prototype
        let thisCell = self.tableView.dequeueReusableCellWithIdentifier("Student") as UITableViewCell

        thisCell.textLabel?.text = self.students[indexPath.row]["FirstName"] as? String ?? ""
        
        return thisCell
    }
    
    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showGrades"{
            if let gtvc = segue.destinationViewController as? gradesTableViewController{
                
                gtvc.sycamoreConnection = self.sycamoreConnection
                
                if let cell = sender as? UITableViewCell{
                    let index = self.tableView.indexPathForCell(cell)?.row
                    gtvc.student = self.students[ index! ]
                    gtvc.title = (gtvc.student["FirstName"] as? String ?? "") + " " + (gtvc.student["LastName"] as? String ?? "")
                }
                
            }
            
        }
    }
    
    //MARK: SycamoreDelegate
    func sycamoreDataReceived(data: AnyObject?, dataTitle: String) {

        //printing stuff to the console for debug purposes
        println("\n\n\n\(dataTitle) received!!\n\n")

        switch dataTitle{
        
        //if "Me" was received, then get student info
        case "Me":
            if let familyID = data?["FamilyID"] as? String{
                self.sycamoreConnection.getStudents(familyID)
            }else{
                println("No family ID received in Me request!!")
            }
            
        //If "Students" were received, then load the tableView
        case "Students":
            self.students = data as? [[String:AnyObject]] ?? [[String:AnyObject]]()
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()

        //anything else is not expected because it was not requested
        default:
            println("WARNING:  received something that wasn't expected!!")
        }
    }
    
    func tokenReceived(){
        
        //change label
        self.loginButton.title = "Log Out"
        self.activityIndicator.startAnimating()

        //Since token was received, get user's info
        self.sycamoreConnection.getMe()

    }

}
