//
//  DetailViewContracts.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import Foundation

enum DetailModelOutput {
  case didUpdateInfos(_ result: Result<DetailResponseModel, Error>)
}

protocol DetailViewModelDelegete: AnyObject {
  func handleOutput(_ output: DetailModelOutput)
}
