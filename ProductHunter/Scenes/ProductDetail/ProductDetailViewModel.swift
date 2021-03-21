//
//  ProductDetailViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewModelProtocol: ViewModel {
  func getHeaderModel() -> ProductDetailHeaderDataModel
  func getProductImageUrl() -> URL?
  func getReviews() -> ReviewTableViewDataSource
}


final class ProductDetailViewModel: ViewModel {
  weak var delegate: ProductDetailViewModelDelegate?
  
  private let product: Product
  
  init(product: Product) {
    self.product = product
  }
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
  
  func getHeaderModel() -> ProductDetailHeaderDataModel {
    let ratingAmount: CGFloat = CGFloat(product.reviews.map { $0.rating }.reduce(0, +) / product.reviews.count)
    return ProductDetailHeaderDataModel(name: product.name, price: "\(product.currency) \(product.price)", description: product.description, ratingAmount: ratingAmount)
  }
  
  func getProductImageUrl() -> URL? {
    product.imgURL
  }
  
  func getReviews() -> ReviewTableViewDataSource {
    product.reviews.map { ReviewTableViewCellDataModel(locale: $0.locale, review: $0.text, rating: $0.rating ) }
  }
}


