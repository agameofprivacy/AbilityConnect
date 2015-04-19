//
//  LoginViewController.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var logoImageView:UIImageView!
    var usernameTextField:UITextField!
    var passwordTextField:UITextField!
    var loginButton:UIButton!
    var signupButton:UIButton!
    
    var scrollView:TPKeyboardAvoidingScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(PFInstallation.currentInstallation()["currentUser"] != nil){
            self.performSegueWithIdentifier("loginToFeed", sender: nil)
        }
        else{
            self.scrollView = TPKeyboardAvoidingScrollView(frame: CGRectZero)
            self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.view.addSubview(self.scrollView)
            
            self.logoImageView = UIImageView(frame: CGRectZero)
            self.logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.logoImageView.contentMode = UIViewContentMode.ScaleAspectFill
            self.logoImageView.image = UIImage(named: "logo")
            self.scrollView.addSubview(self.logoImageView)
            
            self.usernameTextField = UITextField(frame: CGRectZero)
            self.usernameTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.usernameTextField.placeholder = "username"
            self.usernameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            self.scrollView.addSubview(self.usernameTextField)
            
            self.passwordTextField = UITextField(frame: CGRectZero)
            self.passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.passwordTextField.placeholder = "password"
            self.passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            self.passwordTextField.secureTextEntry = true
            self.scrollView.addSubview(self.passwordTextField)
            
            self.loginButton = UIButton(frame: CGRectZero)
            self.loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.loginButton.setTitle("Login", forState: UIControlState.Normal)
            self.loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            var loginTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "loginButtonTapped")
            self.loginButton.addGestureRecognizer(loginTapGestureRecognizer)
            self.loginButton.layer.borderColor = UIColor.blackColor().CGColor
            self.loginButton.layer.borderWidth = 1
            self.loginButton.layer.cornerRadius = 8
            self.loginButton.contentEdgeInsets.top = 10
            self.loginButton.contentEdgeInsets.bottom = 10
            self.loginButton.accessibilityLabel = "Log in"
            self.scrollView.addSubview(self.loginButton)
            
            self.signupButton = UIButton(frame: CGRectZero)
            self.signupButton.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.signupButton.setTitle("Signup", forState: UIControlState.Normal)
            self.signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.signupButton.layer.borderColor = UIColor.blackColor().CGColor
            self.signupButton.layer.borderWidth = 1
            self.signupButton.layer.cornerRadius = 8
            self.signupButton.contentEdgeInsets.top = 10
            self.signupButton.contentEdgeInsets.bottom = 10
            self.signupButton.accessibilityLabel = "Sign up"
            var signupTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "signupButtonTapped")
            self.signupButton.addGestureRecognizer(signupTapGestureRecognizer)
            self.scrollView.addSubview(self.signupButton)
            
            var metricsDictionary = ["verticalTextFieldMargin":20]
            var viewsDictionary = ["logoImageView":self.logoImageView, "usernameTextField":self.usernameTextField, "passwordTextField":self.passwordTextField, "loginButton":self.loginButton, "signupButton":self.signupButton, "scrollView":self.scrollView]
            
            var logoHorizontalCenterConstraint = NSLayoutConstraint(item: self.logoImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            self.scrollView.addConstraint(logoHorizontalCenterConstraint)
            
            var verticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|->=80-[logoImageView]-verticalTextFieldMargin-[usernameTextField]-verticalTextFieldMargin-[passwordTextField]-60-[loginButton]-verticalTextFieldMargin-[signupButton]->=0-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
            self.scrollView.addConstraints(verticalConstraints)
            
            var horizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[logoImageView]-15-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            self.scrollView.addConstraints(horizontalConstraints)
            
            var horizontalScrollViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            var verticalScrollViewConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
            
            self.view.addConstraints(horizontalScrollViewConstraints)
            self.view.addConstraints(verticalScrollViewConstraints)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginButtonTapped(){
        println("login!")
        self.loginButton.enabled = false
        self.usernameTextField.enabled = false
        self.passwordTextField.enabled = false
        PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password:self.passwordTextField.text) {
            (user, error) -> Void in
            if user != nil {
                // Do stuff after successful login.
                PFInstallation.currentInstallation()["currentUser"] = PFUser.currentUser()
                PFInstallation.currentInstallation().saveInBackgroundWithBlock(nil)
                self.performSegueWithIdentifier("loginToFeed", sender: nil)
            } else {
                // The login failed. Check error to see why.
                self.loginButton.enabled = true
                self.usernameTextField.enabled = true
                self.passwordTextField.enabled = true
            }
        }

    }
    
    func signupButtonTapped(){
        println("signup")
        self.performSegueWithIdentifier("showSignup", sender: nil)
    }
    

}
