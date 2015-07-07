//
//  WebPageViewController.swift
//  college profile builder
//
//  Created by Kathy Gallo on 7/7/15.
//  Copyright © 2015 Paul Schmidt. All rights reserved.
//

import UIKit

class WebPageViewController: UIViewController {
    @IBOutlet weak var collegeWebView: UIWebView!

    var webpage : NSURL! = NSURL(string: "https://google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let request : NSURLRequest = NSURLRequest(URL: webpage)
        //collegeWebView.loadRequest(request)
        //print(webpage)
        
    }
}
