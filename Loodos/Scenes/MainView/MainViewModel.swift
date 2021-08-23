//
//  MainViewModel.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

class MainViewModel {
  
  weak var delegate: MainViewModelDelegete?
  
  func fetchMovies() {
    NetworkManager.shared.request(API.getSearch(title: "Dark"), type: [ListResponseModel].self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.delegate?.handleOutput(.didFetchList(.success(())))
      case .failure(let error):
        self.delegate?.handleOutput(.didFetchList(.failure(error)))
      }
    }
  }
  
//  func fetchDetails() {
//    NetworkManager.shared.request(API.getDetail(id: "tt0468569"), type: DetailResponseModel.self) { [weak self] (result) in
//      switch result {
//      case .success(let data):
//        print(data)
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
//  }
}
