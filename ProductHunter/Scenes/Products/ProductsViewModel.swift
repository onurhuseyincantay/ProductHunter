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
}
