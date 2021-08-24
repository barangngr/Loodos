//
//  MainViewModel.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

class MainViewModel {
  
  var dataSource: [ListResponseModel] = []
  weak var delegate: MainViewModelDelegete?
  
  func fetchMovies() {
    NetworkManager.shared.request(API.getSearch(title: "Dark"), type: SearchResponseModel.self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        if let content = data.Search {
          self.dataSource.append(contentsOf: content)
        }
        self.delegate?.handleOutput(.didFetchList(.success(data)))
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
