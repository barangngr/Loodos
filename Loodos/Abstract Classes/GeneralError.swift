//
//  GeneralError.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

enum GeneralError: Error {
  case notConnected
}

extension GeneralError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .notConnected:
      return "You have no internet connection"
    }
  }
}

