//
//  ProductDetailViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit


protocol ProductDetailViewModelDelegate: UIViewController {
  
}

final class ProductDetailViewModel: ViewModel {
  weak var delegate: ProductDetailViewModelDelegate?
  
  let product: Product
  
  init(product: Product) {
    self.product = product
  }
}
