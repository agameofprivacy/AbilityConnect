//
//  SearchViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class SearchViewController: XLFormViewController {

    var searchParamsDictionary:[String:[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Search"

        var addButton = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Done, target: self, action: "confirmButtonTapped")
        addButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = addButton
        
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        // Initiate XLForm objects
        let form = XLFormDescriptor(title:"Suggest Solution")
        var section:XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        

        section = XLFormSectionDescriptor.formSectionWithTitle("Include") as! XLFormSectionDescriptor
        form.addFormSection(section)
        row = XLFormRowDescriptor(tag: "Problem", rowType: XLFormRowDescriptorTypeBooleanCheck, title: "Problem")
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Solution", rowType: XLFormRowDescriptorTypeBooleanCheck, title: "Solution")
        section.addFormRow(row)

        
        section = XLFormSectionDescriptor.formSectionWithTitle("Contains") as! XLFormSectionDescriptor
        form.addFormSection(section)

        row = XLFormRowDescriptor(tag: "Title", rowType: XLFormRowDescriptorTypeText, title: "Title")
        row.cellConfig.setObject("optional", forKey: "textField.placeholder")
        row.required = true
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Detail", rowType: XLFormRowDescriptorTypeText, title: "Detail")
        row.cellConfig.setObject("optional", forKey: "textField.placeholder")
        row.required = true
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Contains Tags (Optional)", sectionOptions: XLFormSectionOptions.CanReorder | XLFormSectionOptions.CanInsert | XLFormSectionOptions.CanDelete) as! XLFormSectionDescriptor
        section.multivaluedTag = "tagsRows"
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: nil, rowType:XLFormRowDescriptorTypeText, title: nil)
        row.cellConfig.setObject("Add a new tag", forKey: "textField.placeholder")
        row.required = false
        section.addFormRow(row)
        
        self.form = form
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func confirmButtonTapped(){
        println("confirm search")
        var values = self.form.formValues()
        var includesArray:[String] = []
        if (((values["Problem"])?.boolValue) != nil){
            println("Include Problem")
            includesArray.append("Problem")
        }
        else{
            println("No Problem")
        }
        if (((values["Solution"])?.boolValue) != nil){
            println("Include Solution")
            includesArray.append("Solution")
        }
        else{
            println("No Solution")
        }
        if includesArray.count == 0{
            includesArray = ["Problem", "Solution"]
        }
        self.searchParamsDictionary = ["includes":includesArray]
        if values["Title"] as? String != nil{
            var title = values["Title"] as! String
            self.searchParamsDictionary.updateValue([title], forKey: "title")
        }
        if values["Detail"] as? String != nil{
            var detail = values["Detail"] as! String
            self.searchParamsDictionary.updateValue([detail], forKey: "detail")
        }
        if (values["tagsRows"] as! [String]).count != 0{
            var tags = values["tagsRows"] as! [String]
            self.searchParamsDictionary.updateValue(tags, forKey: "tags")
        }
        (self.presentingViewController?.childViewControllers[0] as! FeedTableViewController).searchParamsDictionary = self.searchParamsDictionary
        (self.presentingViewController?.childViewControllers[0] as! FeedTableViewController).loadFeedItems("search")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func closeButtonTapped(){
        println("close search")
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
