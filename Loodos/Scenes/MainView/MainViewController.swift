//
//  MainViewController.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

class MainViewController: UIViewController, LoadingViewPresentable {
  
  // MARK: Properties
  private lazy var viewModel = MainViewModel()
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .charlestonGreen
    viewModel.delegate = self
    startAnimating()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.fetchMovies()
  }
  
  // MARK: Functions
  private func configureNavigationBar() {
    title = "Loodos"
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.makeTransparent()
    navigationItem.setHidesBackButton(true, animated: false)
    navigationController?.navigationBar.setTitleFont(UIFont(name: "HelveticaNeue-Bold", size: 23)!, color: .verdigris)
  }
  
}

extension MainViewController: MainViewModelDelegete {
  
  func handleOutput(_ output: MainModelOutput) {
  
    switch output {
    case .didFetchList(let result):
      switch result {
      case .success:
        stopAnimating()
      case .failure(let error):
        showErrorController(with: error)
      }
    }
    
  }
  
}
