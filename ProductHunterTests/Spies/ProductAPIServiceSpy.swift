//
//  ProductAPIServiceSpy.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import Foundation
@testable import ProductHunter

final class ProductAPIServiceSpy: NetworkService<ProductTarget>, ProductApiServiceProtocol {
  var providedDataSource: ProductList!
  var expectedProduct: Product!
  
  var isFailingActive: Bool = false
  func fetchProductByID(_ id: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
    if isFailingActive {
      completion(.failure(.unknown))
    } else {
      completion(.success(expectedProduct))
    }
  }
  
  func fetchAllProducts(completion: @escaping (Result<ProductList, NetworkError>) -> Void) {
    if isFailingActive {
      completion(.failure(.unknown))
    } else {
      completion(.success(providedDataSource))
    }
  }
}
