//
//  UICollectionView+Extensions.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import UIKit

extension UICollectionView {
  
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .verdigris
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    messageLabel.sizeToFit()
    self.backgroundView = messageLabel;
  }
  
  func restore() {
    self.backgroundView = nil
  }
  
  func reloadData(_ completion: @escaping ()->Void) {
    self.reloadData()
    completion()
  }
}
