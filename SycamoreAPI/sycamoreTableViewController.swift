//
//  sycamoreTableViewController.swift
//  SycamoreAPI
//
//  Created by Drew Rosenberg on 11/2/14.
//  Copyright (c) 2014 Drew Rosenberg. All rights reserved.
//

import UIKit

class sycamoreTableViewController: UITableViewController, SycamoreDelegate {

    
    //MARK:  Generic items
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //these variables are set at the Segue from the previous view Controller
    var sycamoreConnection : Sycamore? //the same connection is passed from viewController to viewController
    
    //this variable is populated using the SycamoreAPI
    var tableItems = [[String : AnyObject]]()
    
    override func viewDidLoad() {
        //set sycamoreConnection's delegate
        self.sycamoreConnection?.delegate = self
        
        //if login credentials already exist, then move on to token received
        if (sycamoreConnection?.loggedIn != nil){
            self.tokenReceived()
        }
        
        //add pull down to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //set sycamoreConnection's delegate when the view comes back
        self.sycamoreConnection?.delegate = self
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableItems.count
    }
    
    func tokenReceived(){
        self.activityIndicator.startAnimating()
        
        self.refresh()
    }

    
    //MARK: Custom Items
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //change the identifier
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as? UITableViewCell
        
        //custom cell items go here

        return cell!
    }
    
    
    func sycamoreDataReceived(data: AnyObject?, dataTitle: String) {
        //custom data received items go here
    }
    
    
    func refresh(){
        //get info here

        //stop the refresh control
        self.refreshControl?.endRefreshing()
    }
    

}
