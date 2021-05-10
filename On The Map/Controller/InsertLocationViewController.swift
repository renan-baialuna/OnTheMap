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
    var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkTextField.delegate = self
        linkTextField.tag = 0
        locationTextField.delegate = self
        locationTextField.tag = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
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
        } else {
            self.showAlert(title: "Error", message: "Please choose a valid location")
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let active = self.activeTextField {
            if active.tag == 1 {
                view.frame.origin.y = -getKeyboardHeight(notification)
            }
        }
    }
    
    @objc func keyboardWillDisapear(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(keyboardWillShow(_:)),
                                            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisapear(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
}
