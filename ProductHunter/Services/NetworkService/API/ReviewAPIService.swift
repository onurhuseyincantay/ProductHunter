//
//  ReviewAPIService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import Foundation
protocol ReviewApiServiceProtocol: NetworkService<ReviewTarget> {
  func addReview(productID: String, text: String, rating: Int, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

final class ReviewApiService: NetworkService<ReviewTarget> { }

extension ReviewApiService: ReviewApiServiceProtocol {
  
  func addReview(productID: String, text: String, rating: Int, completion: @escaping (Result<Void, NetworkError>) -> Void) {
    requestPlain(target: .addReview(productID: productID, text: text, rating: rating), completion: completion)
  }
}
