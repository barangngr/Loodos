//
//  DetailLabel.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import UIKit

class DetailLabel: UILabel {
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  func commonInit(){
    self.translatesAutoresizingMaskIntoConstraints = false
    self.textColor = .white
    self.textAlignment = .left
    self.font = UIFont.boldSystemFont(ofSize: 14)
    self.numberOfLines = 0
  }
  
}
