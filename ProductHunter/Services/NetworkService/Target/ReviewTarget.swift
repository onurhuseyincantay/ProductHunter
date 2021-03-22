//
//  ReviewTarget.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import Foundation

enum ReviewTarget {
  case addReview(productID: String, text: String, rating: Int)
}

extension ReviewTarget: NetworkTarget {
  // TODO: Move Base URL to ConfigurationFile
  var baseURL: URL { URL(string: "http://localhost:3002")!  }
  
  var path: String {
    switch self {
    case let .addReview(productID,_,_):
      return "reviews/\(productID)"
    }
  }
  
  var methodType: MethodType {
    switch self {
    case .addReview:
      return .post
    }
  }
  
  var contentType: ContentType {
    .applicationJson
  }
  
  var workType: WorkType {
    switch self {
    case let .addReview(productID, text, rating):
      let parameters: Parameters = [
        "productId": productID,
        "locale": Locale.enUS.rawValue,
        "rating": rating,
        "text": text
      ]
      return .requestWithBodyParameters(parameters: parameters)
    }
  }
}
