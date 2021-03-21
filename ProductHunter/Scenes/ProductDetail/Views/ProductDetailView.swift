//
//  ProductDetailView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewDelegate: UIViewController {
  func didPressBack()
}

final class ProductDetailView: BaseView {
  weak var delegate: ProductDetailViewDelegate?
  var reviewDataSource: ReviewTableViewDataSource = []
  
  private var productImageView: UIImageView!
  private var addReviewView: AddReviewView?
  private var tableView: UITableView!
  private var productDetailHeaderView: ProductDetailHeaderView!
  private var backButton: UIButton!
  
  
  private enum ViewTraits {
    static let productImageViewMinimumHeight: CGFloat = 260
    static let defaultPadding: CGFloat = 16
    static let backButtonWidthHeight: CGFloat = 24
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Public
extension ProductDetailView {
  
  func provideDataModelForHeader(_ model: ProductDetailHeaderDataModel, imageUrl: URL?) {
    productDetailHeaderView.provideDataModel(model)
    guard let url = imageUrl else {
      return
    }
    productImageView.setCachedImage(from: url, placeholder: AssetHelper.productPlaceHolderImage, isTemplate: false)
  }
  
  func provideDataSource(_ dataSource: ReviewTableViewDataSource) {
    reviewDataSource = dataSource
  }
}

// MARK: - UITableViewDataSource
extension ProductDetailView: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    ProductDetailSectionType.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch ProductDetailSectionType(rawValue: section) {
    case .section:
      return reviewDataSource.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {
      assertionFailure("Register required Cell")
      return .init()
    }
    let model = reviewDataSource[indexPath.row]
    cell.prepareCell(with: model)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ProductDetailView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let type = ProductDetailSectionType(rawValue: section) else {
      return nil
    }
    switch type {
    case .header:
      return productImageView
    case .section:
      return productDetailHeaderView
    }
  }
}

// MARK: - Selectors
@objc private extension ProductDetailView {
  
  func didPressBack() {
    delegate?.didPressBack()
  }
}


// MARK: - Private
private extension ProductDetailView {
  
  func setupUIComponents() {
    backgroundColor = ColorHelper.backgroundWhite
    setupTableView()
    setupProductImageView()
    setupProductDetailHeaderView()
    setupBackButton()
  }
  
  func setupProductImageView() {
    productImageView = UIImageView()
  }
  
  func setupProductDetailHeaderView() {
    productDetailHeaderView = ProductDetailHeaderView()
  }
  
  func setupAddReviewView() {
    
  }
  
  func setupTableView() {
    tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
  }
  
  func setupBackButton() {
    backButton = UIButton()
    backButton.setImage(AssetHelper.backButtonImage, for: .normal)
    backButton.tintColor = .black
    backButton.addTarget(self, action: #selector(didPressBack), for: .touchUpInside)
  }
}


// MARK: - Constraints
private extension ProductDetailView {
  
  func addSubviews()  {
    addSubviewWC(tableView)
    addSubviewWC(backButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.defaultPadding),
      backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      backButton.widthAnchor.constraint(equalToConstant: ViewTraits.backButtonWidthHeight),
      backButton.heightAnchor.constraint(equalToConstant: ViewTraits.backButtonWidthHeight),
      
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      productImageView.heightAnchor.constraint(equalToConstant: ViewTraits.productImageViewMinimumHeight)
    ])
  }
}

