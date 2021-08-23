//
//  SplashViewContracts.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

enum ViewModelOutput {
  case updateSplashText(_ text: String)
//  case showMainViewController
}

protocol SplashViewModelDelegete: AnyObject {
  func handleOutput(_ output: ViewModelOutput)
}
