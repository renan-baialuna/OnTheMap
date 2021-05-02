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
                    self.showLoginFailure(title: "Error", message: "Credentential not accepted")
                }
            }
        }
    }
    
    func showLoginFailure(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
  
    }
    
}
