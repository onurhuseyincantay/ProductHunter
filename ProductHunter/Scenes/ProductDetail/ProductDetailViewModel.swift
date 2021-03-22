//
//  ProductDetailViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewModelProtocol: ViewModel {
  func getProduct()
}


final class ProductDetailViewModel: ViewModel {
  weak var delegate: ProductDetailViewModelDelegate?
  
  private var product: Product
  private let productAPIService: ProductApiServiceProtocol
  
  init(product: Product, productAPIService: ProductApiServiceProtocol) {
    self.product = product
    self.productAPIService = productAPIService
  }
}

// MARK: - ProductDetailViewModelProtocol
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
  
  func getProduct() {
    productAPIService.fetchProductByID(product.id) { result in
      switch result {
        
      case let .success(product):
        guard product != self.product else {
          return self.provideResponse()
        }
        self.product = product
      case .failure:
        break
      }
      self.provideResponse()
    }
  }
}

// MARK: - Private
extension ProductDetailViewModel {
  
  func provideResponse() {
    let headerModel = self.getHeaderModel()
    let imageUrl = self.product.imgURL
    let dataSource = self.getReviews()
    self.delegate?.didUpdateProduct(with: dataSource, headerModel: headerModel, imageUrl: imageUrl)
  }
  
  func getHeaderModel() -> ProductDetailHeaderDataModel {
    let ratingAmount: CGFloat = product.reviews.map { CGFloat($0.rating) }.reduce(0, +) / CGFloat(product.reviews.count)
    return ProductDetailHeaderDataModel(name: product.name, price: "\(product.currency) \(product.price)", description: product.description, ratingAmount: ratingAmount)
  }
  
  func getReviews() -> ReviewTableViewDataSource {
    product.reviews.map { ReviewTableViewCellDataModel(locale: $0.locale, review: $0.text, rating: $0.rating ) }
  }
}


