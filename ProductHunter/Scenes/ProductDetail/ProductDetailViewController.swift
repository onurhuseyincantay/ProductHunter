//
//  ProductDetailViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

final class ProductDetailViewController: UIViewController, ViewControllerProtocol {
  typealias ViewType = ProductDetailView
  typealias ViewModelType = ProductDetailViewModel
  
  private let mainView: ViewType
  private let viewModel: ViewModelType
  
  init(view: ProductDetailView, viewModel: ProductDetailViewModel) {
    self.mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    viewModel.delegate = self
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ProductDetailViewModelDelegate
extension ProductDetailViewController: ProductDetailViewModelDelegate {
  
}
