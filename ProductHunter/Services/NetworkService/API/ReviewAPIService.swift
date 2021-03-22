//
//  ReviewAPIService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import Foundation
protocol ReviewApiServiceProtocol: NetworkService<ReviewTarget> {
  
  /// Sends a Review to the backend
  /// - Parameters:
  ///   - productID: specifier to the product as id
  ///   - text: review description
  ///   - rating: rating amount
  ///   - completion:  Result with Success(Void) or Failure(NetworkError)
  func addReview(productID: String, text: String, rating: Int, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

final class ReviewApiService: NetworkService<ReviewTarget> { }

// MARK: - ReviewApiServiceProtocol
extension ReviewApiService: ReviewApiServiceProtocol {
  
  func addReview(productID: String, text: String, rating: Int, completion: @escaping (Result<Void, NetworkError>) -> Void) {
    requestPlain(target: .addReview(productID: productID, text: text, rating: rating), completion: completion)
  }
}
