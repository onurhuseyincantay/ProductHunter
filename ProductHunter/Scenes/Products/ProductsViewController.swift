//
//  ProductsViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit


final class ProductsViewController: UIViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView
  
  private let mainView: ProductsView
  private let viewModel: ProductsViewModel
  
  init(view: ProductsView, viewModel: ProductsViewModel) {
    self.mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    viewModel.delegate = self
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - ProductsViewModelDelegate
extension ProductsViewController: ProductsViewModelDelegate {

}

