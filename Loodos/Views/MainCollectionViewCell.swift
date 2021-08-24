//
//  MainCollectionViewCell.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: BaseUICollectionViewCell {
  
  // MARK: Properties
  var imageView = UIImageView().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFit
  })
  
  private var titleLabel = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .white
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 18.0)
    $0.numberOfLines = 0
  })
  
  private var yearLabel = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .americanRed
    $0.textAlignment = .left
    $0.font = UIFont.systemFont(ofSize: 16.0)
  })
  
  // MARK: Functions
  override func configureViews() {
    addSubview(views: imageView, titleLabel, yearLabel)
    
    imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
  
    titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    
    yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    yearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    yearLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
  }
  
  func configure(with model: ListResponseModel?) {
    titleLabel.text = model?.Title
    yearLabel.text = model?.Year
    imageView.kf.setImage(with: URL(string: model?.Poster ?? ""))
  }
  
}
