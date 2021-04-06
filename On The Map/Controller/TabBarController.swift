//
//  TabBarController.swift
//  On The Map
//
//  Created by Renan Baialuna on 05/04/21.
//

import UIKit

protocol reloadDelegate {
    func reloadData()
}

class TabBarController: UITabBarController {

    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    var students: [StudentLocation] = []
    var reloadDelegate: reloadDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        OTMClient.getStudentsLocations { (students, error) in
            if error == nil {
                self.appDelegate.students = students
                self.reloadDelegate?.reloadData()
            } else {
                
            }
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        getData()
        reloadDelegate?.reloadData()
    }
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("map")
    }
}
