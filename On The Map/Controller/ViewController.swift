//
//  ViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 03/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        OTMClient.getStudentsLocations { (students, error) in
            for student in students {
                print(student.firstName)
            }
        }
    }


}

