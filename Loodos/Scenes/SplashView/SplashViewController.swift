//
//  ViewController.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

class SplashViewController: UIViewController {
  
  // MARK: IBOutlets
  @IBOutlet weak var splashLabel: UILabel!
  
  // MARK: Properties
  private lazy var viewModel = SplashViewModel()
  private var timer: Timer?
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    viewModel.fetchText()
  }
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.checkNetwork()
  }
    
  // MARK: Functions
  private func addTimer(){
    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
  }
  
  // MARK: Actions
  @objc func fireTimer() {
    navigationController?.show(MainViewController(), sender: nil)
  }
    
}

// MARK: - Extensions
extension SplashViewController: SplashViewModelDelegete {
  func handleOutput(_ output: ViewModelOutput) {
    switch output {
    case .didFetchText(let text):
      splashLabel.text = text
      addTimer()
    case .didCheckNetwork(let error):
      showErrorController(with: error)
    }
  }
}
