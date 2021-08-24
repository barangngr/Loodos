//
//  LoadingViewPresentable.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit
import CaseSPM

protocol LoadingViewPresentable: AnyObject {}

extension LoadingViewPresentable where Self: UIViewController {

  func startAnimating() {
    let loadingIndicator = UIActivityIndicatorView()
    loadingIndicator.backgroundColor = .clear
    loadingIndicator.color = .americanRed
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    loadingIndicator.tag = 912
    loadingIndicator.layer.zPosition = 99
    view.addSubview(loadingIndicator)
    loadingIndicator.fill(.horizontally)
    loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    loadingIndicator.startAnimating()
  }

  func stopAnimating() {
    if let indicator =  view.subviews.first(where: {$0.tag == 912 }) as? UIActivityIndicatorView {
      indicator.stopAnimating()
    }
  }

}
