//
//  AnalyticEvents.swift
//  Loodos
//
//  Created by Baran on 25.08.2021.
//

import Firebase

enum AnalyticEvents: String {
  
  case viewScreen
  case selectItem
  
  var analyticsId: String {
    return self.rawValue.camelCaseToSnakeCase()
  }
  
  public func logEvent(_ params: [String: Any]) {
    Analytics.logEvent(analyticsId, parameters: params)
  }
  
}

// MARK: String Extension
extension String {
  func camelCaseToSnakeCase() -> String {
    let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
    let normalPattern = "([a-z0-9])([A-Z])"
    return self.processCamalCaseRegex(pattern: acronymPattern)?
      .processCamalCaseRegex(pattern: normalPattern)?.lowercased() ?? self.lowercased()
  }
  
  fileprivate func processCamalCaseRegex(pattern: String) -> String? {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: count)
    return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
  }
}
