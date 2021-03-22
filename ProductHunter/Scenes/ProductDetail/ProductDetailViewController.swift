//
//  ProductDetailViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewModelDelegate: UIViewController {
  func didUpdateProduct(with dataSource: ReviewTableViewDataSource, headerModel: ProductDetailHeaderDataModel, imageUrl: URL?)
  func didRecieveAddReviewResponse(isSuccessfull: Bool)
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
    viewModel.getProduct()
  }
}

// MARK: - ProductDetailViewModelDelegate
extension ProductDetailViewController: ProductDetailViewModelDelegate {
 
  func didRecieveAddReviewResponse(isSuccessfull: Bool) {
    showAlert(isSuccessfull: isSuccessfull)
  }
  
  
  func didUpdateProduct(with dataSource: ReviewTableViewDataSource, headerModel: ProductDetailHeaderDataModel, imageUrl: URL?) {
    mainView.prepareView(dataSource, headerModel: headerModel, imageUrl: imageUrl)
  }
}

// MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
  
  func didSendReview(reviewText: String, rating: Int) {
    viewModel.sendReview(reviewText: reviewText, rating: rating)
  }
 
  func didPressBack() {
    navigationController?.popViewController(animated: true)
  }
  
  func showAlert(isSuccessfull: Bool) {
    DispatchQueue.main.async {
      let title = "Add Review"
      let description = isSuccessfull ? "Review Successfully Submitted" : "Ooops something went wrong :("
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(.init(title: "OK", style: .destructive))
      self.present(alert, animated: true)
    }
  }
}
