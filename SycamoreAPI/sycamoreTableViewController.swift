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
    
    //**** WARNING:  If these methods are overridden, then super must be called ****

    //MARK: Initialization
    override func viewDidLoad() {
        //set sycamoreConnection's delegate
        self.sycamoreConnection?.delegate = self
        
        //if login credentials already exist, then move on to token received
        if (sycamoreConnection?.loggedIn == true){
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

    //MARK: TableViewController
    //Number of rows in section is covered.  CellforRowAtIndexPath must be called by the inheriting cleass
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableItems.count
    }
    
    //MARK: SycamoreDelegate Methods
    func tokenReceived(){
        self.activityIndicator.startAnimating()
        
        self.refresh()
    }

    
    //MARK: Custom SycamoreDelegate Items
    //NOTE:  These MUST be overridden.  Call super at the end of overriding the method

    func sycamoreDataReceived(data: AnyObject?, dataTitle: String) {
        //printing stuff to the console for debug purposes
        println("\n\n\n\(dataTitle) received!!\n\n")
    }
    
    func refresh(){
        //stop the refresh control
        self.refreshControl?.endRefreshing()
    }
    

}
