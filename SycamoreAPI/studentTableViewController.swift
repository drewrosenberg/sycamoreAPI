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
    
    override func viewDidLoad() {
        
        //set sycamoreConnection's delegate
        self.sycamoreConnection.delegate = self

        //TODO: Remove or move to SycamoreAPI.swift
//        self.sycamoreConnection.pullAuthenticationTokenFromUserDefaults()
        
        if sycamoreConnection.loggedIn{
            self.tokenReceived()
        }
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if loginButton.title == "Log In"{
            sycamoreConnection.request_token()
        }else{
            sycamoreConnection.logout()
            self.loginButton.title = "Log In"
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let students = self.sycamoreConnection.sycamoreData["Students"] as? [[String:AnyObject]]{
            return self.sycamoreConnection.sycamoreData["Students"]?.count ?? 0
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisCell = self.tableView.dequeueReusableCellWithIdentifier("Student") as UITableViewCell?
        
        if let studentList = sycamoreConnection.sycamoreData["Students"] as? [AnyObject]{
            
            if let thisStudent = studentList[indexPath.row] as? [String: AnyObject]{
                thisCell?.textLabel?.text = thisStudent["FirstName"] as? String ?? ""
            }
            
        }
        
        return thisCell!
    }
    
    func sycamoreDataReceived(dataReceived:  String) {
        self.tableView.reloadData()
        
        //TODO: Delete
        println("\n\n\n\(dataReceived) received!!\n\n")
        println("\(self.sycamoreConnection.sycamoreData.count)")

        switch dataReceived{
        case "Me":
            self.sycamoreConnection.getStudents()
        case "Students":
            println("students")
        default:
            println("WARNING:  received something that wasn't expected!!")
        }
    }
    
    func tokenReceived(){
        self.loginButton.title = "Log Out"

        //TODO: Remove
        self.sycamoreConnection.getMe()

    }

}
