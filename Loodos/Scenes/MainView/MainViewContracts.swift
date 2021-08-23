//
//  MainViewContracts.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

enum MainModelOutput {
  case didFetchList(_ result: Result<Void, Error>)
}

protocol MainViewModelDelegete: AnyObject {
  func handleOutput(_ output: MainModelOutput)
}
