//
//  APICall.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation


struct API {

  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  enum Gets: Endpoint {
    case list
    case detail

    public var url: String {
      switch self {
      case .list: return "\(API.baseUrl)games"
      case .detail: return "\(API.baseUrl)games/"
      }
    }
  }
}
