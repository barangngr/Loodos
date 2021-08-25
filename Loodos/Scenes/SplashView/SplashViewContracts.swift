//
//  SplashViewContracts.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

enum ViewModelOutput {
  case didFetchText(_ text: String)
  case didCheckNetwork(_ error: Error)
}

protocol SplashViewModelDelegete: AnyObject {
  func handleOutput(_ output: ViewModelOutput)
}
