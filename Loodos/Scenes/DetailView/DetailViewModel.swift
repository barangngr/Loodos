//
//  DetailViewModel.swift
//  Loodos
//
//  Created by Baran on 24.08.2021.
//

import Foundation

class DetailViewModel {
  
  weak var delegate: DetailViewModelDelegete?
  
  func fetchDetails(_ id: String?) {
    guard let id = id else { return }
    NetworkManager.shared.request(API.getDetail(id: id), type: DetailResponseModel.self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.delegate?.handleOutput(.didUpdateInfos(.success(data)))
      case .failure(let error):
        self.delegate?.handleOutput(.didUpdateInfos(.failure(error)))
      }
    }
  }
  
}
