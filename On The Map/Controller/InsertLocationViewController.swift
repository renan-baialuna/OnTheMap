//
//  InsertLocationViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 06/04/21.
//

import UIKit
import MapKit

class InsertLocationViewController: UIViewController {
    var annotation: CLLocationCoordinate2D?
    
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkTextField.delegate = self
        linkTextField.tag = 0
        locationTextField.delegate = self
        locationTextField.tag = 1
    }
    
    func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    @IBAction func setLocation() {
        if let locationString = locationTextField.text, locationString != "" {
            getCoordinate(addressString: locationString) { (coordinates, error) in
                if error == nil {
                    self.annotation = coordinates
                    self.performSegue(withIdentifier: "mapDetail", sender: self)
                } else {
                    self.showAlert(title: "Error", message: "Location Not Found")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapDetail" {
            var controller = segue.destination as! MapConfirmationViewController
            controller.coordinate = self.annotation
            controller.mapString = locationTextField.text
            controller.mediaURL = linkTextField.text
        } else {
            print("Não encontrado")
        }
    }
}

extension InsertLocationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.resignFirstResponder()
            setLocation()
        } else {
            textField.resignFirstResponder()
            locationTextField.becomeFirstResponder()
        }
        return false
    }
}
