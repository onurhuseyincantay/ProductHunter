//
//  ProductsViewModelTests.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import XCTest
@testable import ProductHunter

final class ProductsViewModelTests: XCTestCase {
  private var sut: ProductsViewModel!
  private var productAPIServiceSpy: ProductAPIServiceSpy!
  private var viewControllerSpy: ProductsViewModelDelegateSpy!
  private var testDataSource: ProductList!
  
  override func setUp() {
    super.setUp()
    testDataSource = [.init(currency: "", price: 0, id: "someUniqID", name: "some name", description: "", imgURL: nil, reviews: []),
                      .init(currency: "", price: 0, id: "asdasd123", name: "some name", description: "", imgURL: nil, reviews: [])]
    productAPIServiceSpy = ProductAPIServiceSpy()
    sut = ProductsViewModel(productAPIService: productAPIServiceSpy)
    viewControllerSpy = ProductsViewModelDelegateSpy()
    sut.delegate = viewControllerSpy
  }
  
  override func tearDown() {
    productAPIServiceSpy = nil
    viewControllerSpy = nil
    sut = nil
    testDataSource = nil
    super.tearDown()
  }
}

// MARK: - Tests
extension ProductsViewModelTests {
  
  func testFetchAllProducts() {
    fetchAllProducts()
  }
  
  func testFetchAllProductsFailure() {
    viewControllerSpy.didFailForGettingProductsExpectation = expectation(description: "didFailForGettingProductsExpectation")
    productAPIServiceSpy.isFailingActive = true
    sut.fetchAllProducts()
    wait(for: [viewControllerSpy.didFailForGettingProductsExpectation], timeout: 0.1)
  }
  
  func testSelectItemWithoutFilteredList() {
    fetchAllProducts()
    let indexPath: IndexPath = .init(row: 0, section: 0)
    let item =  sut.selectItem(at: indexPath)
    XCTAssertEqual(testDataSource[indexPath.row], item)
  }
  
  func testFilterProductsWithExistingValue() {
    filterProductsForValue(value: testDataSource[0].id, expectedValueAmount: 1)
  }
  
  func testFilterProductsWithNonExistingValue() {
    fetchAllProducts()
    let expectedDataSource = sut.filterProduct(with: "asfkjahskdjdahsjkdhaskdjasd")
    XCTAssertEqual(expectedDataSource.count, 0)
  }
  
  func testFilterProductsWithNilValue() {
    filterProductsForValue(value: nil, expectedValueAmount: 2)
  }
}


// MARK: - Private
private extension ProductsViewModelTests {
  
  func compareTestDataSource(productList: ProductList, expectedDataSource: [ProductTableViewCellModel]) {
    for x in 0..<expectedDataSource.count {
      let product = productList[x]
      let expectedCellModel = expectedDataSource[x]
      let name = "Product Name: \(product.name)"
      let price = "\(product.currency.isEmpty ? "$" : product.currency) \(product.price)"
      let description = "Description: \(product.description)"
      XCTAssertEqual(name, expectedCellModel.title)
      XCTAssertEqual(description, expectedCellModel.description)
      XCTAssertEqual(product.imgURL, expectedCellModel.imageUrl)
      XCTAssertEqual(price, expectedCellModel.price)
    }
  }
  
  func fetchAllProducts() {
    productAPIServiceSpy.providedDataSource = testDataSource
    viewControllerSpy.didGetProductsExpectation = expectation(description: "didGetProductsExpectation")
    sut.fetchAllProducts()
    wait(for: [viewControllerSpy.didGetProductsExpectation], timeout: 0.1)
    guard testDataSource.count == viewControllerSpy.dataSource.count else {
      XCTFail("DataSource amount should be equal")
      return
    }
    compareTestDataSource(productList: testDataSource, expectedDataSource: viewControllerSpy.dataSource)
  }
  
  func filterProductsForValue(value: String?, expectedValueAmount: Int) {
    fetchAllProducts()
    let expectedDataSource = sut.filterProduct(with: value)
    guard expectedDataSource.count == expectedValueAmount else {
      XCTFail("DataSource amount should be equal \(expectedValueAmount)")
      return
    }
    compareTestDataSource(productList: testDataSource, expectedDataSource: expectedDataSource)
  }
}
