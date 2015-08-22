//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!

    @IBOutlet var registeredLabel: UILabel!
    var isRegistered = false
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signup(sender: AnyObject) {
        if(username.text=="" || password.text == "") {
            displayAlert("Error in form", message: "Please enter a username and password")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            var errorMessage = "Please try again later"
            if(!isRegistered) {
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if(error == nil) {
                        self.performSegueWithIdentifier("login", sender: self)
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                            self.displayAlert("Failed Signup", message: errorMessage)
                        }
                    }
                    
                })
            } else {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: {( user, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if(user != nil) {
                        self.performSegueWithIdentifier("login", sender: self)
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMessage)
                    }
                    
                })
            }
            
            
        }
    }
    @IBAction func login(sender: AnyObject) {
        if(!isRegistered) {
            signupButton.setTitle("Login", forState: UIControlState.Normal)
            loginButton.setTitle("Signup", forState: UIControlState.Normal)
            registeredLabel.text = "Not registered?"
            isRegistered = !isRegistered
        } else {
            signupButton.setTitle("Signup", forState: UIControlState.Normal)
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            registeredLabel.text = "Already registered?"
            isRegistered = !isRegistered
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        if(PFUser.currentUser() != nil) {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

