//
//  ProductDetailViewModelDelegateSpy.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import XCTest
@testable import ProductHunter

final class ProductDetailViewModelDelegateSpy: UIViewController, ProductDetailViewModelDelegate {
  
  var didRecieveAddReviewResponseExpectation: XCTestExpectation!
  var addReviewIsSuccessfull: Bool!
  
  var didUpdateProductExpectation: XCTestExpectation!
  var dataSource: ReviewTableViewDataSource!
  var headerModel: ProductDetailHeaderDataModel!
  var imageUrl: URL?
  
  func didUpdateProduct(with dataSource: ReviewTableViewDataSource, headerModel: ProductDetailHeaderDataModel, imageUrl: URL?) {
    self.dataSource = dataSource
    self.headerModel = headerModel
    self.imageUrl = imageUrl
    didUpdateProductExpectation.fulfill()
  }
  
  func didRecieveAddReviewResponse(isSuccessfull: Bool) {
    addReviewIsSuccessfull = isSuccessfull
    didRecieveAddReviewResponseExpectation.fulfill()
  }
}
