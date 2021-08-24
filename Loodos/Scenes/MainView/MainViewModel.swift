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
  
  func fetchMovies(_ title: String, page: String = "1") {
    cleanDataSoruce(page)
    NetworkManager.shared.request(API.getSearch(title: title, page: page), type: SearchResponseModel.self) { [weak self] (result) in
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
  
  private func cleanDataSoruce(_ page: String) {
    if page == "1" {
      dataSource.removeAll()
    }
  }
  
}
