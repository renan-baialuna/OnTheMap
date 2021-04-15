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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        getCoordinate(addressString: "Av. 9 de Julho, 1060 - quadra K - Vila Virginia, Jundiaí - SP, 13209-011") { (coordinates, error) in
            if error == nil {
                print(coordinates.latitude)
                print(coordinates.longitude)
                self.annotation = coordinates
                self.performSegue(withIdentifier: "mapDetail", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapDetail" {
            var controller = segue.destination as! MapConfirmationViewController
            controller.coordinate = self.annotation
        } else {
            print("Não encontrado")
        }
    }
    
}
