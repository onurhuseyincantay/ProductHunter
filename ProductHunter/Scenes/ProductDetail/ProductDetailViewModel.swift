//
//  ProductDetailViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewModelProtocol: ViewModel {
  func getProduct()
  func sendReview(reviewText: String, rating: Int)
}


final class ProductDetailViewModel: ViewModel {
  weak var delegate: ProductDetailViewModelDelegate?
  
  private var product: Product
  private let productAPIService: ProductApiServiceProtocol
  private let reviewAPIService: ReviewApiServiceProtocol
  
  init(product: Product, productAPIService: ProductApiServiceProtocol, reviewAPIService: ReviewApiServiceProtocol) {
    self.product = product
    self.productAPIService = productAPIService
    self.reviewAPIService = reviewAPIService
  }
}

// MARK: - ProductDetailViewModelProtocol
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
  
  func sendReview(reviewText: String, rating: Int) {
    reviewAPIService.addReview(productID: product.id, text: reviewText, rating: rating) { result in
      switch result {
      case .success:
        self.delegate?.didRecieveAddReviewResponse(isSuccessfull: true)
        
      case .failure:
        self.delegate?.didRecieveAddReviewResponse(isSuccessfull: false)
      }
    }
  }

  func getProduct() {
    productAPIService.fetchProductByID(product.id) { result in
      switch result {
      case let .success(product):
        guard product != self.product else {
          return self.provideResponse()
        }
        self.product = product
        self.provideResponse()
      case .failure:
        self.provideResponse()
      }
    }
  }
}

// MARK: - Private
private extension ProductDetailViewModel {
  
  func provideResponse() {
    let headerModel = getHeaderModel()
    let imageUrl = product.imgURL
    let dataSource = getReviews()
    delegate?.didUpdateProduct(with: dataSource, headerModel: headerModel, imageUrl: imageUrl)
  }
  
  func getHeaderModel() -> ProductDetailHeaderDataModel {
    var ratingAmount: CGFloat
    if product.reviews.count != 0 {
      ratingAmount = product.reviews.map { CGFloat($0.rating) }.reduce(0, +) / CGFloat(product.reviews.count)
    } else {
      ratingAmount = 0
    }
   
    let name = "Product Name: \(product.name)"
    let price = "\(product.currency.isEmpty ? "$" : product.currency) \(product.price)"
    let description = "Description: \(product.description)"
    return ProductDetailHeaderDataModel(name: name, price: price, description: description, ratingAmount: ratingAmount)
  }
  
  func getReviews() -> ReviewTableViewDataSource {
    product.reviews.map { ReviewTableViewCellDataModel(locale: $0.locale, review: $0.text, rating: $0.rating ) }
  }
}


