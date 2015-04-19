//
//  NewSolutionViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class NewSolutionViewController: XLFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var addButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "addButtonTapped")
        addButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = addButton
        
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton
        // Initiate XLForm objects
        let form = XLFormDescriptor(title:"Suggest Solution")
        var section:XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        // Required section
        section = XLFormSectionDescriptor()
        form.addFormSection(section)
        row = XLFormRowDescriptor(tag: "Title", rowType: XLFormRowDescriptorTypeText, title: "Title")
        row.cellConfig.setObject("required", forKey: "textField.placeholder")
        row.required = true
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Detail", rowType: XLFormRowDescriptorTypeTextView, title: "Detail")
        row.cellConfig.setObject("Describe the solution...(required)", forKey: "textView.placeholder")
        row.required = true
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "URL", rowType: XLFormRowDescriptorTypeURL, title: "URL")
        row.cellConfig.setObject("optional", forKey: "textField.placeholder")
        row.required = false
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Tags (Optional)", sectionOptions: XLFormSectionOptions.CanReorder | XLFormSectionOptions.CanInsert | XLFormSectionOptions.CanDelete) as! XLFormSectionDescriptor
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addButtonTapped(){
        println("add solution")
        var values = self.form.formValues()
        var solution = PFObject(className: "Solution")
        if values["Title"] as? String != nil && values["Detail"] as? String != nil{
            solution["author"] = PFUser.currentUser()
            solution["title"] = values["Title"] as? String
            solution["detail"] = values["Detail"] as? String
            if (values["tagsRows"] as! [String]).count == 0{
                solution["tags"] = []
            }
            else{
                solution["tags"] = values["tagsRows"] as! [String]
            }
            if values["URL"] as? String == nil{
                solution["URL"] = ""
            }
            else{
                solution["url"] = values["URL"] as? String
            }
            solution.saveInBackgroundWithBlock{
                (succeeded, error) -> Void in
                if error == nil{
                    println("solution suggested!")
                    (self.presentingViewController?.childViewControllers[0] as! FeedTableViewController).loadFeedItems("new")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else{
                    println("solution failed to save!")
                }
            }
        }
    }
    
    func closeButtonTapped(){
        println("close problem")
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
