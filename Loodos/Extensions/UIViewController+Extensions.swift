//
//  UIViewController+Extensions.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

extension UIViewController {
  
  func showErrorController(with error: Error, title: String = "Error") {
    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
}
