//
//  gradesTableViewController.swift
//  SycamoreAPI
//
//  Created by Drew Rosenberg on 11/1/14.
//  Copyright (c) 2014 Drew Rosenberg. All rights reserved.
//

import UIKit

class gradesTableViewController: UITableViewController, SycamoreDelegate {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var student = [String : AnyObject]()
    var grades = [[String : AnyObject]]()
    var sycamoreConnection : Sycamore?

    override func viewDidLoad() {
        //set sycamoreConnection's delegate
        self.sycamoreConnection?.delegate = self
        
        //if login credentials already exist, then move on to token received
        if (sycamoreConnection?.loggedIn != nil){
            self.tokenReceived()
        }
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.grades.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("gradeCell") as? UITableViewCell
        
        let thisClass = self.grades[indexPath.row]

        cell?.textLabel?.text = thisClass["ClassName"] as? String ?? ""

        cell?.detailTextLabel?.text = thisClass["Letter"] as? String ?? ""
        
        //if no letter grade was available, then present the number grade
        if cell?.detailTextLabel?.text == ""{
            cell?.detailTextLabel?.text = thisClass["Number"] as? String ?? "N/A"
        }
        
        return cell!
    }


    //MARK: SycamoreDelegate
    func sycamoreDataReceived(data: AnyObject?, dataTitle: String) {
        
        //printing stuff to the console for debug purposes
        println("\n\n\n\(dataTitle) received!!\n\n")
        
        switch dataTitle{
            
        case "Grades":
            self.grades = data as? [[String:AnyObject]] ?? [[String:AnyObject]]()
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()

        default:
            println("WARNING:  received something that wasn't expected!!")
        }
    }

    func tokenReceived(){
        self.activityIndicator.startAnimating()
        
        //Since token was received, get user's info
        if let studentID = self.student["ID"] as? String{
            self.sycamoreConnection?.getGrades(studentID, quarter: 1)
        }
    }

}
