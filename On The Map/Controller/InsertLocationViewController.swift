//
//  InsertLocationViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 06/04/21.
//

import UIKit

class InsertLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func setLocation() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
