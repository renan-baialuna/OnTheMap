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
                putLocation(location: location, mediaURL: mediaURL)
            } else {
                postLocation(location: location, mediaURL: mediaURL)
            }
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        } else {
//            error treatment
        }
    }
    
    func putLocation(location: Location, mediaURL: String) {
        let url = OTMClient.Endpoints.putLocation(OTMClient.Auth.id).url
        let body = UserRegistrationData(id: OTMClient.Auth.id, firstName: OTMClient.User.firstName, lastName: OTMClient.User.lastName, mediaURL: mediaURL, location: location)
        OTMClient.taskForPUTRequest(url: url, responseType: UpdateDate.self, body: body) { (response, error) in
            if error == nil {
            } else {
                self.showLoginFailure(title: "Error", message: "Unable to complete action")
            }
        }
    }
    
    func postLocation(location: Location, mediaURL: String) {
        let body = UserRegistrationData(id: OTMClient.Auth.id, firstName: OTMClient.User.firstName, lastName: OTMClient.User.lastName, mediaURL: mediaURL, location: location)
        OTMClient.taskForPOSTRequest(url: OTMClient.Endpoints.postLocation.url, responseType: SucessCreationReturn.self, body: body) { (response, error) in
            if error == nil {
            } else {
                self.showLoginFailure(title: "Error", message: "Unable to complete action")
            }
        }
    }
}
