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
    }
    
    func getData() {
        OTMClient.getStudentsLocations { (students, error) in
            if error == nil {
                self.appDelegate.students = students
                self.reloadDelegate?.reloadData()
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "There was a problem with getting data, returning to login", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        getData()
        reloadDelegate?.reloadData()
    }
    
    @IBAction func mapButtonPressed(_ sender: Any) {
        if OTMClient.Auth.hasLocation {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Warning!", message: "You have a location registered, overwrite?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
                    self.moveToNext()
                }))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            moveToNext()
        }
        
    }
    
    func moveToNext() {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        
        OTMClient.logoutUser()
        self.navigationController!.popToRootViewController(animated: true)
    }
}
