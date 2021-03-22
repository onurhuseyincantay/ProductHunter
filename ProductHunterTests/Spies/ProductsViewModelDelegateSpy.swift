//
//  ProductsViewModelDelegateSpy.swift
//  ProductHunterTests
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import XCTest
@testable import ProductHunter

final class ProductsViewModelDelegateSpy: UIViewController, ProductsViewModelDelegate {
  
  var didGetProductsExpectation: XCTestExpectation!
  var dataSource: [ProductTableViewCellModel]!
  
  func didGetProducts(dataSource: [ProductTableViewCellModel]) {
    self.dataSource = dataSource
    didGetProductsExpectation.fulfill()
  }
}
