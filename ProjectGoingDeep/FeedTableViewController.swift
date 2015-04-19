//
//  FeedTableViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var feedItems:NSMutableArray = []
    var alertController:UIAlertController!
    var tableViewRefreshControl:UIRefreshControl!
    var temporaryArray:NSMutableArray = []
    var searchParamsDictionary:[String:[String]]!
    var noOlderItems = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = TPKeyboardAvoidingTableView(frame: self.view.frame)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerClass(FeedProblemTableViewCell.self, forCellReuseIdentifier: "FeedProblemTableViewCell")
        self.tableView.registerClass(FeedSolutionTableViewCell.self, forCellReuseIdentifier: "FeedSolutionTableViewCell")
        self.tableViewRefreshControl = UIRefreshControl(frame: self.tableView.frame)
        self.tableViewRefreshControl.addTarget(self, action: "getNewFeedItems", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.tableViewRefreshControl)

        
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonTapped")
        addButton.tintColor = UIColor.blackColor()
        var searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchButtonTapped")
        searchButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItems = [addButton, searchButton]
        
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutButtonTapped")
        logoutButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = logoutButton
        
        self.navigationItem.title = "AbilityConnect"

        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {(alertController:UIAlertAction!) in
        }
        
        var problemAction = UIAlertAction(title: "Submit a Problem", style: UIAlertActionStyle.Default) {(alertController:UIAlertAction!) in self.addNewProblem()}
        
        var solutionAction = UIAlertAction(title: "Suggest a Solution", style: UIAlertActionStyle.Default) {(alertController:UIAlertAction!) in self.addNewSolution()}
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(problemAction)
        alertController.addAction(solutionAction)
        
        self.loadFeedItems("new")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.feedItems.count
    }

    func logoutButtonTapped(){
        PFInstallation.currentInstallation().removeObjectForKey("currentUser")
        PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil)
        PFUser.logOut()
        self.performSegueWithIdentifier("loggedOut", sender: nil)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var item = self.feedItems[indexPath.row] as! PFObject
        if item.parseClassName == "Problem"{
            var cell:FeedProblemTableViewCell = tableView.dequeueReusableCellWithIdentifier("FeedProblemTableViewCell") as! FeedProblemTableViewCell
            var title = item["title"] as! String
            cell.titleLabel.text = "Problem: \(title)"
            cell.detailLabel.text = item["detail"] as? String
            var tagsString:String = ""
            if (item["tags"] as! [String]).count > 0{
                for tag in item["tags"] as! [String]{
                    tagsString += ("\(tag) ")
                }
            }
            cell.tagsLabel.text = tagsString
            cell.numberOfUpvotesLabel.text = "\(5) people relate to this problem"
            cell.numberOfCommentsLabel.text = "\(8) people commented on this problem"
            println("problem")
            return cell
        }
        else{
            var cell:FeedSolutionTableViewCell = tableView.dequeueReusableCellWithIdentifier("FeedSolutionTableViewCell") as! FeedSolutionTableViewCell
            var title = item["title"] as! String
            cell.titleLabel.text = "Solution: \(title)"
            cell.detailLabel.text = item["detail"] as? String
            var tagsString:String = ""
            if (item["tags"] as! [String]).count > 0{
                for tag in item["tags"] as! [String]{
                    tagsString += ("\(tag) ")
                }
            }
            cell.tagsLabel.text = tagsString
            cell.numberOfUpvotesLabel.text = "\(5) people like this solution"
            cell.numberOfCommentsLabel.text = "\(8) people commented on this solution"
            println("solution")

            return cell
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.feedItems.count - 1 && !self.noOlderItems{
            self.loadFeedItems("old")
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 280
    }

    func addButtonTapped(){
        self.presentViewController(self.alertController, animated: true, completion: nil)
    }
    
    func addNewProblem(){
        self.performSegueWithIdentifier("showNewProblem", sender: nil)
    }
    
    func addNewSolution(){
        self.performSegueWithIdentifier("showNewSolution", sender: nil)
    }
    
    func searchButtonTapped(){
        self.performSegueWithIdentifier("showSearch", sender: nil)
    }
    
    func getNewFeedItems(){
        self.loadFeedItems("new")
    }
    
    func loadFeedItems(context:String){
        var problemQuery = PFQuery(className: "Problem")
        var solutionQuery = PFQuery(className: "Solution")
        var timeStamp:NSDate
        if self.feedItems.count > 0 && context != "search"{
            if context == "new"{
                timeStamp = (self.feedItems.firstObject as! PFObject).updatedAt!
                problemQuery.whereKey("updatedAt", greaterThan: timeStamp)
                solutionQuery.whereKey("updatedAt", greaterThan: timeStamp)
            }
            else{
                timeStamp = (self.feedItems.lastObject as! PFObject).updatedAt!
                problemQuery.whereKey("updatedAt", lessThan: timeStamp)
                solutionQuery.whereKey("updatedAt", lessThan: timeStamp)
            }
        }
        if context == "search"{
            for param in self.searchParamsDictionary{
                switch param.0{
                    case "tags":
                        var tags = param.1 as [String]
                        problemQuery.whereKey("tags", containsAllObjectsInArray: tags)
                        solutionQuery.whereKey("tags", containsAllObjectsInArray: tags)
                        println(tags)
                    case "title":
                        problemQuery.whereKey("title", containsString: param.1[0] as String)
                        solutionQuery.whereKey("title", containsString: param.1[0] as String)
                    case "detail":
                        problemQuery.whereKey("detail", containsString: param.1[0] as String)
                        solutionQuery.whereKey("detail", containsString: param.1[0] as String)
                    default:
                        println("includes")
                }
            }
        }

        problemQuery.findObjectsInBackgroundWithBlock{
        (objects, error) -> Void in
            if error == nil{
                self.temporaryArray = NSMutableArray(array: [])
                if context == "search"{

                    var includes = (self.searchParamsDictionary["includes"])!
                    println(includes)
                    if contains(includes, "Problem"){
                        self.temporaryArray.addObjectsFromArray(objects!)
                        println(self.temporaryArray)
                    }
                }
                else{
                    self.temporaryArray.addObjectsFromArray(objects!)
                }
                solutionQuery.findObjectsInBackgroundWithBlock{
                    (objects, error) -> Void in
                    if error == nil{
                        if context == "search"{
                            var includes = (self.searchParamsDictionary["includes"])!
                            println(includes)
                            if contains(includes, "Solution"){
                                println("find solutions")
                                self.temporaryArray.addObjectsFromArray(objects!)
                            }
                        }
                        else{
                            self.temporaryArray.addObjectsFromArray(objects!)
                        }
                        if self.temporaryArray.count == 0{
                            self.noOlderItems = true
                        }
                        var dateDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
                        var sortDescriptors = NSArray(array: [dateDescriptor])
                        var sortedItemsArray = self.temporaryArray.sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                        if context == "new"{
                            var range = NSMakeRange(0, sortedItemsArray.count)
                            self.feedItems.insertObjects(sortedItemsArray, atIndexes: NSIndexSet(indexesInRange: range))
                        }
                        if context == "old"{
                            self.feedItems.addObjectsFromArray(sortedItemsArray)
                        }
                        if context == "search"{
                            self.feedItems.removeAllObjects()
                            self.feedItems.addObjectsFromArray(sortedItemsArray)
                        }
                        self.temporaryArray.removeAllObjects()
                        self.tableViewRefreshControl.endRefreshing()
                        if context == "new"{
                            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                        }
                        if context == "old"{
                            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                        }
                        if context == "search"{
                            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                        }
                        println(self.tableView.numberOfRowsInSection(0))
                    }
                    else{
                        println("nothing")
                    }
                }
            }
            else{
                println("nothing")
            }
        }
    
    }
}
