//
//  TabBarController.swift
//  On The Map
//
//  Created by Renan Baialuna on 05/04/21.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        print("refresh")
    }
    @IBAction func mapButtonPressed(_ sender: Any) {
        print("map")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
