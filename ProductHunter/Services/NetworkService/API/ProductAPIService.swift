//
//  ProductAPIService.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

protocol ProductApiServiceProtocol: NetworkService<ProductTarget> {
  func fetchProductByID(_ id: String, completion: @escaping (Result<Product, NetworkError>) -> Void)
  func fetchAllProducts(completion: @escaping (Result<ProductList, NetworkError>) -> Void)
  func addProduct(name: String, description: String, imageUrl: String?, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

final class ProductApiService: NetworkService<ProductTarget> {
  
}

extension ProductApiService: ProductApiServiceProtocol {
  
  func fetchProductByID(_ id: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
    request(target: .productByID(id), completion: completion)
  }
  
  func fetchAllProducts(completion: @escaping (Result<ProductList, NetworkError>) -> Void) {
    request(target: .product, completion: completion)
  }
  
  func addProduct(name: String, description: String, imageUrl: String?, completion: @escaping (Result<Void, NetworkError>) -> Void) {
    let target: ProductTarget = .addProduct(name: name, description: description, imageUrl: imageUrl)
    requestPlain(target: target, completion: completion)
  }
}
