//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("Image selected.")
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
    }
    
    @IBAction func importImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    @IBOutlet var importedImage: UIImageView!
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
        
//        var query = PFQuery(className: "TestObject")
//        query.getObjectInBackgroundWithId("Z7WyWhzeyc", block: {(object: PFObject?, error: NSError?) -> Void in
//            if(error != nil) {
//                print(error)
//            } else if let test = object{
//                test["foo"] = "bar"
//                test.saveInBackground()
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

