//
//  ProductDetailViewModelTests.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import XCTest
@testable import ProductHunter

final class ProductDetailViewModelTests: XCTestCase {
  private var sut: ProductDetailViewModel!
  private var productAPIServiceSpy: ProductAPIServiceSpy!
  private var reviewAPIServiceSpy: ReviewAPIServiceSpy!
  private var viewControllerSpy: ProductDetailViewModelDelegateSpy!
  private let testProduct: Product = .init(currency: "", price: 123, id: "someUDID", name: "Some name", description: "Description", imgURL: nil, reviews: [])
  
  override func setUp() {
    super.setUp()
    productAPIServiceSpy = ProductAPIServiceSpy()
    reviewAPIServiceSpy = ReviewAPIServiceSpy()
    viewControllerSpy = ProductDetailViewModelDelegateSpy()
    sut = ProductDetailViewModel(product: testProduct, productAPIService: productAPIServiceSpy, reviewAPIService: reviewAPIServiceSpy)
    sut.delegate = viewControllerSpy
  }
  
  override func tearDown() {
    productAPIServiceSpy = nil
    reviewAPIServiceSpy = nil
    viewControllerSpy = nil
    sut = nil
    super.tearDown()
  }
}

// MARK: - Tests
extension ProductDetailViewModelTests {
  
  func testGetProductSuccessfull() {
    productAPIServiceSpy.expectedProduct = testProduct
    getProduct(isFailureActive: false)
  }
  
  func testGetProductFailure() {
    getProduct(isFailureActive: true)
  }
  
  func testSendReviewSuccessfull() {
    sendReview(isSuccessFull: true)
  }
  
  func testSendReviewFailure() {
    sendReview(isSuccessFull: false)
  }
}

// MARK: - Private
private extension ProductDetailViewModelTests {
  
  func getProduct(isFailureActive: Bool) {
    productAPIServiceSpy.isFailingActive = isFailureActive
    viewControllerSpy.didUpdateProductExpectation = expectation(description: "didUpdateProductExpectation")
    sut.getProduct()
    
    wait(for: [viewControllerSpy.didUpdateProductExpectation], timeout: 0.1)
    guard testProduct.reviews.count == viewControllerSpy.dataSource.count else {
      XCTFail("Review Count should be equal to datasource count")
      return
    }
    compare(testProduct: testProduct, dataSource: viewControllerSpy.dataSource, headerModel: viewControllerSpy.headerModel, imageUrl: viewControllerSpy.imageUrl)
  }
  
  func sendReview(isSuccessFull: Bool) {
    let testReviewText = "Some Text Sample"
    let testRating: Int = 2
    viewControllerSpy.didRecieveAddReviewResponseExpectation = expectation(description: "didRecieveAddReviewResponseExpectation")
    reviewAPIServiceSpy.isSuccessfull = isSuccessFull
    sut.sendReview(reviewText: testReviewText, rating: testRating)
    
    wait(for: [viewControllerSpy.didRecieveAddReviewResponseExpectation], timeout: 0.1)
    XCTAssertEqual(isSuccessFull, viewControllerSpy.addReviewIsSuccessfull)
  }
  
  func compare(testProduct: Product, dataSource: ReviewTableViewDataSource, headerModel: ProductDetailHeaderDataModel, imageUrl: URL?) {
    let ratingAmount: CGFloat = 0
    let name = "Product Name: \(testProduct.name)"
    let price = "\(testProduct.currency.isEmpty ? "$" : testProduct.currency) \(testProduct.price)"
    let description = "Description: \(testProduct.description)"
    XCTAssertEqual(headerModel.name, name)
    XCTAssertEqual(headerModel.description, description)
    XCTAssertEqual(headerModel.price, price)
    XCTAssertEqual(headerModel.ratingAmount, ratingAmount)
    XCTAssertEqual(imageUrl, testProduct.imgURL)
    for x in 0..<dataSource.count {
      let testReview = testProduct.reviews[x]
      let returnedReview = dataSource[x]
      XCTAssertEqual(testReview.text, returnedReview.review)
      XCTAssertEqual(testReview.locale, returnedReview.locale)
      XCTAssertEqual(testReview.rating, returnedReview.rating)
    }
  }
}
