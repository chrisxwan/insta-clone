//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "baz"
//        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
//            
//            if (success) {
//                print("Object has been saved.")
//            } else {
//                print("Failed.")
//            }
//        }
        
        var query = PFQuery(className: "TestObject")
        query.getObjectInBackgroundWithId("Z7WyWhzeyc", block: {(object: PFObject?, error: NSError?) -> Void in
            if(error != nil) {
                print(error)
            } else if let test = object{
                test["foo"] = "bar"
                test.saveInBackground()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

