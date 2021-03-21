//
//  ProductDetailViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewModelDelegate: UIViewController {
  
}

final class ProductDetailViewController: BaseViewController, ViewControllerProtocol {
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
  
  override func loadView() {
    mainView.delegate = self
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    provideDataModelForHeader()
    provideDataSource()
  }
}

// MARK: - ProductDetailViewModelDelegate
extension ProductDetailViewController: ProductDetailViewModelDelegate {
  
}

// MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
  
  func didPressBack() {
    navigationController?.popViewController(animated: true)
  }
}


private extension ProductDetailViewController {
  
  func provideDataModelForHeader() {
    let model = viewModel.getHeaderModel()
    let imageUrl = viewModel.getProductImageUrl()
    mainView.provideDataModelForHeader(model, imageUrl: imageUrl)
  }
  
  func provideDataSource() {
    let dataSource = viewModel.getReviews()
    mainView.provideDataSource(dataSource)
  }
}
