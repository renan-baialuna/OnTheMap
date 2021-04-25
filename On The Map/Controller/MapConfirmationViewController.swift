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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        annotation.title = "primeira"
        annotation.coordinate = coordinate
        annotation.subtitle = "segundo"
        
        map.addAnnotation(annotation)
        let region = MKCoordinateRegion( center: coordinate, latitudinalMeters: CLLocationDistance(exactly: 1000)!, longitudinalMeters: CLLocationDistance(exactly: 1000)!)
        map.setRegion(map.regionThatFits(region), animated: true)
    }
    
    @IBAction func confirmationAction() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
