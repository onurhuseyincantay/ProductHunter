//
//  ProductsViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductsViewModelProtocol: ViewModel {
  func fetchAllProducts()
  func filterProduct(with id: String?) -> [ProductTableViewCellModel]
  func selectItem(at indexPath: IndexPath) -> Product
}

final class ProductsViewModel: ViewModel {
  weak var delegate: ProductsViewModelDelegate?
  private let productAPIService: ProductApiServiceProtocol
  
  private var productList: ProductList = []
  private var filteredList: ProductList?
  init(productAPIService: ProductApiServiceProtocol) {
    self.productAPIService = productAPIService
  }
}

// MARK: - ProductsViewModelProtocol
extension ProductsViewModel: ProductsViewModelProtocol {
  
  func fetchAllProducts() {
    cleanDataSource()
    productAPIService.fetchAllProducts { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
        
      case .success(let productList):
        self.productList = productList
        let dataSource = self.generateProductTableViewCellModel(from: productList)
        self.delegate?.didGetProducts(dataSource: dataSource)
      }
    }
  }
  
  // Normally wee should expect product name or description but since all the products that returns from api has the same name I will filter based on id
  func filterProduct(with id: String?) -> [ProductTableViewCellModel] {
    guard let id = id else {
      filteredList = nil
      return generateProductTableViewCellModel(from: productList)
    }
    filteredList = productList.filter { $0.id.lowercased().range(of: id.lowercased()) != nil }
    return generateProductTableViewCellModel(from: filteredList!)
  }
  
  func selectItem(at indexPath: IndexPath) -> Product {
    let row = indexPath.row
    guard let filtered = filteredList else {
      return self.productList[row]
    }
    return filtered[row]
  }
}

// MARK: - Private
private extension ProductsViewModel {
  
  func generateProductTableViewCellModel(from dataSource: ProductList) -> [ProductTableViewCellModel] {
    dataSource.map { ProductTableViewCellModel(imageUrl: $0.imgURL, title: $0.name, description: $0.description, price: "\($0.currency) \($0.price)") }
  }
  
  func cleanDataSource() {
    filteredList = nil
    productList = []
  }
}



