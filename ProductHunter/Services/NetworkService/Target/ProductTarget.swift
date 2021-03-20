//
//  NetworkService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation
import Hover

enum ProductTarget {
  case product
}

extension ProductTarget: NetworkTarget {
  var baseURL: URL { URL(string: "http://localhost:3001")! }
  
  var path: String {
    switch self {
    case .product:
      return "product"
    }
  }
  
  var methodType: MethodType {
    .get
  }
  
  var workType: WorkType {
    .requestPlain
  }
  
  var providerType: AuthProviderType { .none }
  
  var contentType: ContentType? { .applicationJson }
  
  var headers: [String : String]? { nil }
}
