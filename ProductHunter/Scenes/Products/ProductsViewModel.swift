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
  private let networkManager: NetworkManager
  
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
}

extension ProductsViewModel {
  func fetchAllProducts() {
    networkManager.request(with: ProductTarget.product, class: ProductList.self) { result in
      switch result {
      case let .success(products):
        print(products)
      case let .failure(error):
        print(error.errorDescription)
      }
    }
  }
}
