//
//  BaseUIViewController.swift
//  Loodos
//
//  Created by Baran on 25.08.2021.
//

import UIKit

class BaseUIViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    handleKeyboard()
  }
  
  func configureViews() {
  }
  
  func handleKeyboard() {
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
}
