//
//  DetailViewController.swift
//  college profile builder
//
//  Created by Kathy Gallo on 7/6/15.
//  Copyright © 2015 Paul Schmidt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webAddressTextField: UITextField!
    
    var college : College!
    var imagePicker : UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        collegeTextField.text = college.name
        locationTextField.text = college.location
        enrollmentTextField.text = String(college.enrollment)
        imageView.image = college.image
        webAddressTextField.text = String(college.webAddress)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    @IBAction func onTappedSaveButton(sender: AnyObject) {
        college.name = collegeTextField.text!
        college.location = locationTextField.text!
        college.enrollment = Int(enrollmentTextField.text!)!
        college.webAddress = NSURL(string: webAddressTextField.text!)
    }
    @IBAction func onTappedWebsiteButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(college.webAddress!)
    }
    @IBAction func onTappedEditImageButtom(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = .Camera
        }
        else{
            imagePicker.sourceType = .PhotoLibrary
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true) { () -> Void in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.imageView.image = image
            }
        }
    }
}
