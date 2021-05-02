//
//  MapConfirmationViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 11/04/21.
//

import UIKit
import MapKit

class MapConfirmationViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!

    
    var annotation = MKPointAnnotation()
    var coordinate: CLLocationCoordinate2D!
    var mapString: String!
    var mediaURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        annotation.title = mapString
        annotation.coordinate = coordinate
        
        map.addAnnotation(annotation)
        let region = MKCoordinateRegion( center: coordinate, latitudinalMeters: CLLocationDistance(exactly: 1000)!, longitudinalMeters: CLLocationDistance(exactly: 1000)!)
        map.setRegion(map.regionThatFits(region), animated: true)
    }
    
    @IBAction func confirmationAction() {
        if let coordinate = coordinate, let mapString = mapString, let mediaURL = mediaURL {
            let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude, mapString: mapString)
            if OTMClient.Auth.hasLocation {
                OTMClient.putLocation(location: location, mediaURL: mediaURL)
            } else {
                OTMClient.postLocation(location: location, mediaURL: mediaURL)
            }
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        } else {
//            error treatment
        }
        
    }
}
