//
//  College.swift
//  college profile builder
//
//  Created by Kathy Gallo on 7/6/15.
//  Copyright © 2015 Paul Schmidt. All rights reserved.
//

import UIKit

class College: NSObject {
    var name = ""
    var location = ""
    var enrollment = 0
    var image = UIImage(named: "Default")
    var webAddress:NSURL! = NSURL(string: "http://google.com")
    
    
    convenience init(name: String, location : String, enrollment : Int, image : UIImage, webAddress : NSURL){
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.image = image
        self.webAddress = webAddress
    }
    convenience init(name : String){
        self.init()
        self.name = name
    }
}
