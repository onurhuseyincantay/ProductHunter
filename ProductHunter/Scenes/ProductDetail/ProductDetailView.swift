//
//  ProductDetailView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ProductDetailViewDelegate: UIViewController {
  func didPressBack()
  func didSendReview(reviewText: String, rating: Int)
}

final class ProductDetailView: BaseView {
  weak var delegate: ProductDetailViewDelegate?
  var reviewDataSource: ReviewTableViewDataSource = []
  
  var stickyHeaderIsVisible: Bool { ViewTraits.stickyHeaderHeight == stickyHeaderBottomConstraint.constant }
  
  private var stickyHeaderView: StickyReviewHeaderView!
  private var productImageView: UIImageView!
  private var addReviewView: AddReviewView!
  private var tableView: UITableView!
  private var productDetailHeaderView: ProductDetailHeaderView!
  private var backButton: UIButton!
  
  private var stickyHeaderBottomConstraint: NSLayoutConstraint!
  private var addReviewViewTopConstraint: NSLayoutConstraint!
  
  private enum ViewTraits {
    static let productImageViewMinimumHeight: CGFloat = 260
    static let defaultPadding: CGFloat = 16
    static let backButtonWidthHeight: CGFloat = 24
    static let stickyHeaderHeight: CGFloat = backButtonWidthHeight + defaultPadding * 2.5
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
  
  func prepareView(_ dataSource: ReviewTableViewDataSource, headerModel: ProductDetailHeaderDataModel, imageUrl: URL?) {
    DispatchQueue.main.async {
      self.reviewDataSource = dataSource
      self.productDetailHeaderView.provideDataModel(headerModel)
      self.stickyHeaderView.setText(headerModel.name)
      guard let url = imageUrl else {
        return self.tableView.reloadData()
      }
      self.productImageView.setCachedImage(from: url, placeholder: AssetHelper.productPlaceHolderImage, isTemplate: false)
      self.tableView.reloadData()
    }
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let isVisible = checkIfHeaderViewRectIsVisible(with: scrollView)
    guard isVisible == stickyHeaderIsVisible else {
      return
    }
    animateStickyHeader(isExpanding: !isVisible)
  }
}

// MARK: - AddReviewViewDelegate
extension ProductDetailView: AddReviewViewDelegate {
  
  func didSendReview(reviewText: String, rating: Int) {
    delegate?.didSendReview(reviewText: reviewText, rating: rating)
  }
  
  
  func didPressOpenCloseButton(isExpanding: Bool) {
    animateAddReview(isExpanding: isExpanding)
  }
  
  func keyboardDidShow(isShowing: Bool, keyboardHeight: CGFloat) {
    let constant = isShowing ? -(AddReviewView.totalContainerHeigt + keyboardHeight) : -AddReviewView.textViewTopPadding
    addReviewViewTopConstraint.constant = constant
    let option: UIView.AnimationOptions = isShowing ? .curveEaseIn : .curveEaseOut
    UIView.animate(withDuration: 0.25, delay: 0, options: option, animations: layoutIfNeeded)
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
    setupAddReviewView()
    setupStickyHeaderView()
    setupBackButton()
  }
  
  func setupProductImageView() {
    productImageView = UIImageView()
  }
  
  func setupProductDetailHeaderView() {
    productDetailHeaderView = ProductDetailHeaderView()
  }
  
  func setupAddReviewView() {
    addReviewView = AddReviewView()
    addReviewView.delegate = self
  }
  
  func setupStickyHeaderView() {
    stickyHeaderView = StickyReviewHeaderView()
  }
  
  func setupTableView() {
    tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.bounces = false
    tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
  }
  
  func setupBackButton() {
    backButton = UIButton()
    backButton.setImage(AssetHelper.backButtonImage, for: .normal)
    backButton.tintColor = .black
    backButton.addTarget(self, action: #selector(didPressBack), for: .touchUpInside)
  }
  
  func checkIfHeaderViewRectIsVisible(with scrollView: UIScrollView) -> Bool {
    let rect = CGRect(origin: .zero, size: .init(width: stickyHeaderView.frame.width, height: ViewTraits.stickyHeaderHeight))
    return scrollView.bounds.intersects(rect)
  }
  
  func animateStickyHeader(isExpanding: Bool) {
    stickyHeaderBottomConstraint.constant = isExpanding ? ViewTraits.stickyHeaderHeight : 0
    animate(isExpanding)
  }
  
  func animateAddReview(isExpanding: Bool) {
    addReviewViewTopConstraint.constant = isExpanding ? -(AddReviewView.totalContainerHeigt) : -AddReviewView.textViewTopPadding
    animate(isExpanding)
  }
  
  func animate(_ isExpanding: Bool) {
    let option: UIView.AnimationOptions = isExpanding ? .curveEaseIn : .curveEaseOut
    UIView.animate(withDuration: 0.25, delay: 0, options: option, animations: layoutIfNeeded)
  }
}


// MARK: - Constraints
private extension ProductDetailView {
  
  func addSubviews()  {
    addSubviewWC(tableView)
    addSubviewWC(stickyHeaderView)
    addSubviewWC(backButton)
    addSubviewWC(addReviewView!)
  }
  
  func setupConstraints() {
    stickyHeaderBottomConstraint = stickyHeaderView.bottomAnchor.constraint(equalTo: topAnchor)
    addReviewViewTopConstraint = addReviewView.topAnchor.constraint(equalTo: bottomAnchor, constant: -AddReviewView.textViewTopPadding)
    
    NSLayoutConstraint.activate([
      
      stickyHeaderView.heightAnchor.constraint(equalToConstant: ViewTraits.stickyHeaderHeight),
      stickyHeaderView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stickyHeaderView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stickyHeaderBottomConstraint,
      
      backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.defaultPadding),
      backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      backButton.widthAnchor.constraint(equalToConstant: ViewTraits.backButtonWidthHeight),
      backButton.heightAnchor.constraint(equalToConstant: ViewTraits.backButtonWidthHeight),
      
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      productImageView.heightAnchor.constraint(equalToConstant: ViewTraits.productImageViewMinimumHeight),
      
      addReviewViewTopConstraint,
      addReviewView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      addReviewView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
    ])
  }
}

