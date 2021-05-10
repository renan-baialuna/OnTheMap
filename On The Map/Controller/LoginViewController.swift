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
    @IBOutlet weak var logoImage: UIImageView!
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "logo-u")!.withRenderingMode(.alwaysTemplate)
        logoImage.tintColor = UIColor(named: "detail")
        userTextField.delegate = self
        userTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        unsubscribeToKeyboardNotification()
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
        } else {
            self.showAlert(title: "Error", message: "Please insert both credentials for autentication")
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let active = self.activeTextField {
            if active.tag == 1 {
                view.frame.origin.y = -getKeyboardHeight(notification)
            }
        }
    }
    
    @objc func keyboardWillDisapear(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(keyboardWillShow(_:)),
                                            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisapear(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.resignFirstResponder()
            login()
        } else {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
}
