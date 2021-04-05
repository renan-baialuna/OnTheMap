//
//  ViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 03/04/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        // Do any additional setup after loading the view.
        OTMClient.getStudentsLocations { (students, error) in
            for student in students {
                let annotation = self.studentConverter(student: student)
                self.annotations.append(annotation)
            }
            self.map.addAnnotations(self.annotations)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func studentConverter(student: StudentLocation) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        let lat = student.latitude
        let long = student.longitude
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        annotation.title = student.firstName + " " + student.lastName
        annotation.coordinate = coordinate
        annotation.subtitle = student.mediaURL
        return annotation
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    
}
