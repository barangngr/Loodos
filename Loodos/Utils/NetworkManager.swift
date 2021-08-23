//
//  NetworkManager.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit
import Moya
import Alamofire

class NetworkManager {
  
  static let shared = NetworkManager()
  fileprivate let reachabilityManager = NetworkReachabilityManager()
  
  func checkNetworkConnection(_ completion: @escaping (Error?)-> Void) {
    guard let reachabilityManager = reachabilityManager, reachabilityManager.isReachable else {
      completion(GeneralError.notConnected)
      return
    }
  }
  
}
