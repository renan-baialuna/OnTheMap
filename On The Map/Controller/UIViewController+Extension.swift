//
//  UIViewController+Extension.swift
//  On The Map
//
//  Created by Renan Baialuna on 05/05/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
