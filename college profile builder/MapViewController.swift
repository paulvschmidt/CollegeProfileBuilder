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
    var locationsArray : UIAlertAction!
    
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
            pin.title = pinTitle
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pin)
            self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(textField.text!, completionHandler: {
                placemarks, error in
                if error != nil{
                    print(error)
                }
                else{
                    var sheetDisplay:[CLPlacemark] = []
                    var actionAmount = true

                    if placemarks!.count == 1{
                        let placemark = placemarks!.first as CLPlacemark!
                        let center = placemark.location.coordinate
                        let span = MKCoordinateSpanMake(0.1, 0.1)
                        self.displayMap(center, span: span, pinTitle: self.textField.text!)
                        actionAmount = false
                    }
                    else if placemarks!.count > 1 && placemarks!.count <= 10 {
                        sheetDisplay = placemarks!
                    }
                    else{
                        for (var amount = 0; amount < 5; amount++) {
                            sheetDisplay[amount] = placemarks![amount]
                        }
                    }
                    
                    if actionAmount == true{
                        let actionSheet = UIAlertController(title: "Select Location", message: "Select a location", preferredStyle: .ActionSheet)
                        for(var amount = 0; amount < sheetDisplay.count; amount++){
                            let placemark = placemarks![amount] as CLPlacemark!
                            let center = placemark.location.coordinate
                            let span = MKCoordinateSpanMake(0.1, 0.1)
                            
                            let placerAction = UIAlertAction(title: placemarks![amount].name + ", " + placemarks![amount].administrativeArea , style: .Default){ (action) -> Void in
                                self.displayMap(center, span: span, pinTitle: self.textField.text!)
                            }
                            
                            actionSheet.addAction(placerAction)
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        }
                        
                        actionSheet.addAction(cancelAction)
                        
                        self.presentViewController(actionSheet, animated: true, completion: nil)
                    }
                    
                }
            })
        textField.resignFirstResponder()
        return true
    }
}

