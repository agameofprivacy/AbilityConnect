//
//  SignupViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class SignupViewController: XLFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var closeButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "closeButtonTapped")
        closeButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = closeButton

        var submitButton = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "signupButtonTapped")
        submitButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = submitButton
        
        // Initiate XLForm objects
        let form = XLFormDescriptor(title:"Signup")
        var section:XLFormSectionDescriptor
        var row: XLFormRowDescriptor

        // Required section
        section = XLFormSectionDescriptor.formSectionWithTitle("Required") as! XLFormSectionDescriptor
        form.addFormSection(section)
        row = XLFormRowDescriptor(tag: "Username", rowType: XLFormRowDescriptorTypeAccount, title: "Username")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        let paddingView1 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView1, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "Password", rowType: XLFormRowDescriptorTypePassword, title: "Password")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        var paddingView2 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView2, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "First Name", rowType: XLFormRowDescriptorTypeName, title: "First Name")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        var paddingView4 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView4, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Last Name", rowType: XLFormRowDescriptorTypeName, title: "Last Name")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        var paddingView5 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView5, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Email", rowType: XLFormRowDescriptorTypeEmail, title: "Email")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        var paddingView6 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView6, forKey: "textField.rightView")
        row.required = true
        section.addFormRow(row)
        
        // Optional section
        section = XLFormSectionDescriptor.formSectionWithTitle("Optional") as! XLFormSectionDescriptor
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "Role", rowType: XLFormRowDescriptorTypeSelectorPush, title: "Role")
        row.selectorOptions =
            [
                XLFormOptionsObject(value: "Person with Disability", displayText: "Person with Disability"),
                XLFormOptionsObject(value: "Caregiver", displayText: "Caregiver")
        ]
        row.required = false
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "URL", rowType: XLFormRowDescriptorTypeURL, title: "URL")
        row.cellConfigAtConfigure.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        var paddingView7 = UIView(frame: CGRectMake(0, 0, 7.5, 20))
        row.cellConfig.setObject(paddingView7, forKey: "textField.rightView")
        row.cellConfig.setObject(UITextFieldViewMode.Always.rawValue, forKey: "textField.rightViewMode")
        row.required = true
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: "Bio", rowType: XLFormRowDescriptorTypeTextView, title: "Bio")
        row.cellConfig.setObject("Expand a little on your role...", forKey: "textView.placeholder")
        row.required = false
        section.addFormRow(row)

        self.form = form
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func closeButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func signupButtonTapped(){
        var values = self.form.formValues()
        var user = PFUser()
        
        user.username = values["Username"] as? String
        user.password = values["Password"] as? String
        user["firstName"] = values["First Name"] as? String
        user["lastName"] = values["Last Name"] as? String
        user["email"] = values["Email"] as? String
        if (values["Role"] as! XLFormOptionsObject).valueData() == nil{
            user["role"] = ""
        }
        else{
            user["role"] = (values["Role"] as! XLFormOptionsObject).valueData()
        }
        if (values["URL"] as? String == nil){
            user["url"] = ""
        }
        else{
            user["url"] = values["URL"] as? String
        }
        if (values["Bio"] as? String == nil){
            user["bio"] = ""
        }
        else{
            user["bio"] = values["Bio"] as? String
        }

        user.signUpInBackgroundWithBlock {
            (succeeded, error) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                self.performSegueWithIdentifier("signupToFeed", sender: nil)
            } else {
                // Show the errorString somewhere and let the user try again.
            }
        }

    }
}
