//
//  ViewController.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
  
  // MARK: Properties
  @IBOutlet weak var splashLabel: UILabel!
  
  private var timer: Timer?
  private var remoteConfig = RemoteConfig.remoteConfig()
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRemoteConfigDefaults()
    fetchRemoteConfig()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NetworkManager.shared.checkNetworkConnection { error in
      if let err = error {
        self.showErrorController(with: err)
      }
    }
  }
  
  deinit {
    print("SplashViewController deinit")
  }
  
  // MARK: Functions
  func setupRemoteConfigDefaults() {
    let defaultValue = ["splashText": "--" as NSObject]
    remoteConfig.setDefaults(defaultValue)
  }
  
  func fetchRemoteConfig(){
    remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
      guard error == nil else { return }
      remoteConfig.activate()
      self.displayNewValues()
    }
  }
  
  func displayNewValues(){
    let remoteText = remoteConfig.configValue(forKey: "splashText").stringValue ?? ""
    splashLabel.text = remoteText
    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
  }
  
  // MARK: Actions
  @objc func fireTimer() {
      print("Timer fired!")
  }
    
}
