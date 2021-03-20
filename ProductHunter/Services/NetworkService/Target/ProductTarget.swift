//
//  NetworkService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

enum ProductTarget {
  case product
  case addProduct(name: String, description: String, imageUrl: String?)
}

extension ProductTarget: NetworkTarget {
  var baseURL: URL { URL(string: "http://localhost:3001")! }
  
  var path: String {
    switch self {
    case .product,
         .addProduct:
      return "product"
    
    }
  }
  
  var methodType: MethodType {
    switch self {
    case .addProduct:
      return .post
    case .product:
      return .get
    }
  }
  
  var workType: WorkType {
    switch self {
    case .product:
      return .requestPlain
      
    case let .addProduct(name, description, imageUrl):
      let paramaters: Parameters = [
        "name": name,
        "description": description,
        "imgUrl": imageUrl
      ]
      return .requestWithBodyParameters(parameters: paramaters)
    }
  }
  
  
  var contentType: ContentType { .applicationJson }
}
