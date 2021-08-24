//
//  DetailViewController.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, LoadingViewPresentable, BackButtonPresentable {
  
  // MARK: Properties
  var imageView = UIImageView().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFit
  })
  
  private var titleLabel = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .americanRed
    $0.textAlignment = .center
    $0.font = UIFont.boldSystemFont(ofSize: 23.0)
    $0.numberOfLines = 0
  })
  
  private var genreLabel = DetailLabel()
  private var runtimeLabel = DetailLabel()
  private var directorLabel = DetailLabel()
  private var imdbLabel = DetailLabel()
  private var descriptionLabel = DetailLabel()
  private var authorsLabel = DetailLabel()
  private var actorsLabel = DetailLabel()
  
  var id: String?
  private lazy var viewModel = DetailViewModel()
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .charlestonGreen
    viewModel.delegate = self
    viewModel.fetchDetails(id)
    startAnimating()
    configureViews()
    configureBackButton()
  }
  
  // MARK: Functions
  func configureViews() {
    view.addSubview(views: imageView, titleLabel, genreLabel, runtimeLabel, directorLabel, imdbLabel)
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
    imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    
    genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    genreLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    
    runtimeLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10).isActive = true
    runtimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    runtimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    
    directorLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 10).isActive = true
    directorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    directorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    
    imdbLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 10).isActive = true
    imdbLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    imdbLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    
    view.addSubview(views: descriptionLabel, authorsLabel, actorsLabel)
    descriptionLabel.fill(.horizontally, with: 15)
    authorsLabel.fill(.horizontally, with: 15)
    actorsLabel.fill(.horizontally, with: 15)
    
    descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
    
    authorsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
    
    actorsLabel.topAnchor.constraint(equalTo: authorsLabel.bottomAnchor, constant: 15).isActive = true
    actorsLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10).isActive = true
  }
  
  private func configureData(_ model: DetailResponseModel) {
    imageView.kf.setImage(with: URL(string: model.Poster ?? ""))
    titleLabel.text = model.Title
    genreLabel.text = "Genre: \(model.Genre ?? "")"
    runtimeLabel.text = "Runtime: \(model.Runtime ?? "")"
    directorLabel.text = "Director: \(model.Director ?? "")"
    imdbLabel.text = "Imdb: \(model.imdbRating ?? "")"
    descriptionLabel.text = model.Plot
    authorsLabel.text = "Authors: \(model.Writer ?? "")"
    actorsLabel.text = "Actors: \(model.Actors ?? "")"
  }
  
}

// MARK: - Extensions
extension DetailViewController: DetailViewModelDelegete {
  func handleOutput(_ output: DetailModelOutput) {
    
    switch output {
    case .didUpdateInfos(let result):
      switch result {
      case .success(let data):
        configureData(data)
        stopAnimating()
      case .failure(let error):
        showErrorController(with: error)
      }
    }
    
  }
}
