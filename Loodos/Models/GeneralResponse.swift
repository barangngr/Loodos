//
//  GeneralResponse.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import Foundation

//public class GeneralResponse<T: Codable> : Codable {
//  public var Search: T?
//  public var totalResults: String?
//  public var Response: String?
//}

public class SearchResponseModel: Codable {
  public var Search: [ListResponseModel]?
  public var totalResults: String?
  public var Response: String?
}
