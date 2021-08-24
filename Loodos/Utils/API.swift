//
//  API.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Moya

enum API {
  case getSearch(title: String, page: String)
  case getDetail(id: String)
}

extension API: TargetType {
  
  var baseURL: URL {
    return URL(string: "http://www.omdbapi.com/?")!
  }
  
  var path: String{
      switch self {
      case .getSearch, .getDetail:
          return ""
      }
  }
  
  var apikey: String{
      return "cace1cb3"
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .getSearch(let title, let page):
      return .requestParameters(parameters: ["apikey" : apikey, "s" : title, "page": page], encoding: URLEncoding.queryString)
    case .getDetail(let id):
      return .requestParameters(parameters: ["apikey" : apikey, "i" : id, "plot" : "full"], encoding: URLEncoding.queryString)
    }
  }
  
}
