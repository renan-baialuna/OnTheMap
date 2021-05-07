//
//  LoginViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 14/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func login() {
        
        if let user = userTextField.text, let password = passwordTextField.text, user != "", password != "" {
            OTMClient.loginUser(user: user, password: password) { (response, error) in
                if response {
                    self.performSegue(withIdentifier: "toMain", sender: self)
                } else {
                    if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                        self.showAlert(title: "Error", message: "Connection Problems")
                    } else {
                        self.showAlert(title: "Error", message: "Credententials not accepted")
                    }
                }
            }
        }
    }
}
