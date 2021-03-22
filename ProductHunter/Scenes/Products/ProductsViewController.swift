//
//  ProductsViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductsViewModelDelegate: UIViewController {
  func didGetProducts(dataSource: [ProductTableViewCellModel])
}

final class ProductsViewController: BaseViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView
  
  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol
  
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
    mainView.delegate = self
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchAllProducts()
  }
}

extension ProductsViewController: ProductsViewDelegate {
  
  func didSelectItem(at indexPath: IndexPath) {
    let product = viewModel.selectItem(at: indexPath)
    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product, productAPIService: ProductApiService(), reviewAPIService: ReviewApiService()))
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  
  func searchBarSearchButtonClicked(_ text: String?) {
    mainView.provideDataSource(viewModel.filterProduct(with: text))
  }
  
  func searchBarCancelButtonClicked() {
    mainView.provideDataSource(viewModel.filterProduct(with: nil))
  }
}

// MARK: - ProductsViewModelDelegate
extension ProductsViewController: ProductsViewModelDelegate {
  
  func didGetProducts(dataSource: [ProductTableViewCellModel]) {
    DispatchQueue.main.async {
      self.mainView.provideDataSource(dataSource)
    }
  }
}

