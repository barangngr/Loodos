//
//  SplashViewModel.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation
import Firebase

class SplashViewModel {
  
  // MARK: Properties
  private var remoteConfig = RemoteConfig.remoteConfig()
  weak var delegate: SplashViewModelDelegete?
  
  // MARK: Functions
  func fetchText() {
    setupRemoteConfigDefaults()
    fetchRemoteConfig()
  }
  
  func checkNetwork() {
    NetworkManager.shared.checkNetworkConnection { [weak self] error in
      guard let self = self else { return }
      if let err = error {
        self.delegate?.handleOutput(.didCheckNetwork(err))
      }
    }
  }
  
  private func setupRemoteConfigDefaults() {
    let defaultValue = ["splashText": "--" as NSObject]
    remoteConfig.setDefaults(defaultValue)
  }
  
  private func fetchRemoteConfig(){
    remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
      guard error == nil else { return }
      remoteConfig.activate()
      let remoteText = remoteConfig.configValue(forKey: "splashText").stringValue ?? ""
      delegate?.handleOutput(.didFetchText(remoteText))
    }
  }
 
}
