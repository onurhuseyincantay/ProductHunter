//
//  ReviewAPIServiceSpy.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import Foundation
@testable import ProductHunter

final class ReviewAPIServiceSpy: NetworkService<ReviewTarget>, ReviewApiServiceProtocol {
  
  var isSuccessfull: Bool = false
  
  func addReview(productID: String, text: String, rating: Int, completion: @escaping (Result<Void, NetworkError>) -> Void) {
    isSuccessfull ? completion(.success(())) : completion(.failure(.unknown))
  }
}
