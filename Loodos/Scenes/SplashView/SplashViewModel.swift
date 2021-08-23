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
  weak var delegete: SplashViewModelDelegete?
  
  // MARK: Functions
  func fetchText() {
    setupRemoteConfigDefaults()
    fetchRemoteConfig()
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
      delegete?.handleOutput(.updateSplashText(remoteText))
    }
  }
 
}
