//
//  ProductsViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductsViewModelDelegate: UIViewController {
  
}

final class ProductsViewModel: ViewModel {
  weak var delegate: ProductsViewModelDelegate?
  private let productAPIService: ProductApiServiceProtocol
  
  init(productAPIService: ProductApiServiceProtocol) {
    self.productAPIService = productAPIService
  }
}

extension ProductsViewModel {
  
  func fetchAllProducts() {
    productAPIService.fetchAllProducts { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let productList):
        print(productList)
      }
    }
  }
  
  func addProduct(name: String, description: String, imageUrl: String?) {
    productAPIService.addProduct(name: name, description: description, imageUrl: imageUrl) { result in
      switch result {
      case .success:
        print("Post Success")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
