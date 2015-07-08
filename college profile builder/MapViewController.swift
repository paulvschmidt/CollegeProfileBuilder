//
//  MapViewController.swift
//  college profile builder
//
//  Created by Kathy Gallo on 7/8/15.
//  Copyright © 2015 Paul Schmidt. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    var name = ""
    var location = ""
    var locationsArray : UIAlertAction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "\(name), \(location)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("\(name), \(location)", completionHandler: {
            placemarks, error in
            let placemark = placemarks!.first as CLPlacemark!
            let center = placemark.location.coordinate
            let span = MKCoordinateSpanMake(0.1, 0.1)
            self.displayMap(center, span: span, pinTitle: "\(self.name), \(self.location)")
            
        })
    }
    func displayMap(center: CLLocationCoordinate2D,
        span: MKCoordinateSpan,
        pinTitle: String){
            let region = MKCoordinateRegionMake(center, span)
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = textField.text!
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pin)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let actionSheet = UIAlertController(title: "Possible Locations", message: "Select a location", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let locationsAction = UIAlertAction(title: "killbutt", style: UIAlertActionStyle.Default) { (action) -> Void in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(textField.text!, completionHandler: {
                placemarks, error in
                if error != nil{
                    print(error)
                }
                else if placemarks!.count == 1{
                    let placemark = placemarks!.first as CLPlacemark!
                    let center = placemark.location.coordinate
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    self.displayMap(center, span: span, pinTitle: textField.text!)
                }
                else{
                    for i in placemarks!{
                        let placemark = i as CLPlacemark!
                        let center = placemark.location.coordinate
                        let span = MKCoordinateSpanMake(0.1, 0.1)
                        self.displayMap(center, span: span, pinTitle: textField.text!)
                        
                    }
                }
            })
        }
        actionSheet.addAction(cancelAction)
        textField.resignFirstResponder()
        presentViewController(actionSheet, animated: true, completion: nil)
        return true
    }
    
}
