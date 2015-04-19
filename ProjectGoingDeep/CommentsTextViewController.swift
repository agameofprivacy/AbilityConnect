//
//  CommentsTextViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/19/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class CommentsTextViewController: SLKTextViewController {

    var parentItem:PFObject!
    var comments:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadComments()

        self.tableView.registerClass(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.scrollsToTop = true
        self.bounces = true
        self.keyboardPanningEnabled = true
        self.inverted = true
        self.tableView.frame = self.view.frame
        self.textView.placeholder = "Comment"
        self.textView.placeholderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        self.textView.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1).CGColor
        self.textView.pastableMediaTypes = SLKPastableMediaType.None
        self.rightButton.setTitle("Post", forState: UIControlState.Normal)
        self.textInputbar.autoHideRightButton = true
        self.textInputbar.maxCharCount = 140
        self.textInputbar.counterStyle = SLKCounterStyle.Split
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var comment = self.comments[indexPath.row]
        var cell:CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
        cell.authorLabel.text = (comment["author"] as! PFUser).username
        cell.timeStampLabel.text = comment.createdAt?.timeAgoSinceNow()
        cell.commentContentLabel.text = comment["content"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func didPressRightButton(sender: AnyObject!) {
        self.textView.refreshFirstResponder()
        var comment:String = self.textView.text
        self.tableView.beginUpdates()
        
        var newComment = PFObject(className: "Comment")
        if self.parentItem.parseClassName == "Problem"{
            newComment["problem"] = self.parentItem
        }
        else if self.parentItem.parseClassName == "Solution"{
            newComment["solution"] = self.parentItem
        }
        newComment["author"] = PFUser.currentUser()
        newComment["content"] = comment
        
        self.comments.insert(newComment, atIndex: 0)
        newComment.saveInBackgroundWithBlock{
            (succeeded, error) -> Void in
            if error == nil{
                // Send iOS Notification
//                self.parentVC.parentVC.loadActivities("update")
            }
        }

        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        super.didPressRightButton(sender)
    }

    func loadComments(){
        var commentsQuery = PFQuery(className: "Comment")
        commentsQuery.whereKey(self.parentItem.parseClassName, equalTo: self.parentItem)
        commentsQuery.includeKey("author")
        commentsQuery.orderByDescending("createdAt")
        commentsQuery.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil {
                self.comments = objects as! [PFObject]
                self.tableView.reloadData()
            }
            else {
                // Log details of the failure

            }
        }
    }
}
