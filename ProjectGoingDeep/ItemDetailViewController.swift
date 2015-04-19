//
//  ItemDetailViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var item:PFObject!
    var commentsViewController:CommentsTextViewController!
    var detailTableView:TPKeyboardAvoidingTableView!
    var segmentedControlView:UIView!
    var segmentedControl:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    self.commentsViewController = CommentsTextViewController(tableViewStyle: UITableViewStyle.Plain)
    self.commentsViewController.parentItem = self.item
    self.commentsViewController.view.frame = CGRectZero
    self.commentsViewController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.commentsViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.commentsViewController.view)
        
        self.detailTableView = TPKeyboardAvoidingTableView(frame: CGRectZero)
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        self.detailTableView.estimatedRowHeight = 80
        self.view.addSubview(self.detailTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "value1")
        cell.textLabel!.text = "Text"
        cell.detailTextLabel!.text = "Detail"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        else{
            return 8
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            var headerView = UIView()
            var itemTitleLabel = UILabel(frame: CGRectZero)
            itemTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            headerView.addSubview(itemTitleLabel)
            var horizontalConstraint = NSLayoutConstraint(item: itemTitleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
            var verticalConstraint = NSLayoutConstraint(item: itemTitleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: headerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
            headerView.addConstraint(horizontalConstraint)
            headerView.addConstraint(verticalConstraint)
            return headerView
        }
        else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
