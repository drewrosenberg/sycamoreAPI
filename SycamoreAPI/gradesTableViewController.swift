//
//  gradesTableViewController.swift
//  SycamoreAPI
//
//  Created by Drew Rosenberg on 11/1/14.
//  Copyright (c) 2014 Drew Rosenberg. All rights reserved.
//

import UIKit

class gradesTableViewController: sycamoreTableViewController, SycamoreDelegate {
    
    var student = [String : AnyObject]()
    
    //MARK: Custom TableViewController Items
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("gradeCell") as? UITableViewCell
        
        let thisClass = self.tableItems[indexPath.row]

        cell?.textLabel?.text = thisClass["ClassName"] as? String ?? ""

        cell?.detailTextLabel?.text = thisClass["Letter"] as? String ?? ""
        
        //if no letter grade was available, then present the number grade
        if cell?.detailTextLabel?.text == ""{
            cell?.detailTextLabel?.text = thisClass["Number"] as? String ?? "N/A"
        }
        
        return cell!
    }


    //MARK: Custom SycamoreDelegate items
    override func sycamoreDataReceived(data: AnyObject?, dataTitle: String) {
        
        //printing stuff to the console for debug purposes
        println("\n\n\n\(dataTitle) received!!\n\n")
        
        switch dataTitle{
            
        case "Grades":
            self.tableItems = data as? [[String:AnyObject]] ?? [[String:AnyObject]]()
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()

        default:
            println("WARNING:  received something that wasn't expected!!")
        }
    }
    
    override func refresh(){
        //Since token was received, get user's info
        if let studentID = self.student["ID"] as? String{
            self.sycamoreConnection?.getGrades(studentID, quarter: 1)
        }
        
        self.refreshControl?.endRefreshing()        
    }
}
