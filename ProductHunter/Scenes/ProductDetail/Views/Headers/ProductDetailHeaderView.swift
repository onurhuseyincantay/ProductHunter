//
//  ProductDetailHeaderView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

final class ProductDetailHeaderView: BaseView {
  private var containerView: UIView!
  private var priceLabel: UILabel!
  private var nameLabel: UILabel!
  private var descriptionLabel: UILabel!
  private var ratingView: RatingView!
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 16
    static let contentPadding: CGFloat = 8
    static let ratingViewHeight: CGFloat = 32
    static let ratingViewWidthMultiplier: CGFloat = 0.45
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUICompoments()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Public
extension ProductDetailHeaderView {
  
  func provideDataModel(_ model: ProductDetailHeaderDataModel) {
    nameLabel.text = model.name
    descriptionLabel.text = model.description
    priceLabel.text = model.price
  }
}

// MARK: - Private
private extension ProductDetailHeaderView {
  
  func setupUICompoments() {
    setupContainerView()
    setupNameLabel()
    setupDescriptionLabel()
    setupPriceLabel()
    setupRatingView()
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.layer.cornerRadius = 25
    containerView.clipsToBounds = true
    containerView.backgroundColor = .white
  }
  
  func setupPriceLabel() {
    priceLabel = UILabel()
    priceLabel.numberOfLines = 1
    priceLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    priceLabel.textColor = .green
  }
  
  func setupNameLabel() {
    nameLabel = UILabel()
    nameLabel.numberOfLines = 2
    nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    nameLabel.textColor = .black
  }
  
  func setupDescriptionLabel() {
    descriptionLabel = UILabel()
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
    descriptionLabel.textColor = .darkGray
  }
  
  func setupRatingView() {
    ratingView = RatingView()
    ratingView.backgroundColor = .red
  }
}

// MARK: - Constraints
private extension ProductDetailHeaderView {
  
  func addSubviews() {
    addSubviewWC(containerView)
    containerView.addSubviewWC(nameLabel)
    containerView.addSubviewWC(descriptionLabel)
    containerView.addSubviewWC(priceLabel)
    containerView.addSubviewWC(ratingView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.defaultPadding),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.defaultPadding),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.defaultPadding),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.defaultPadding),
    ])
    setupContainerConstraints()
  }
  
  func setupContainerConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.contentPadding),
      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.defaultPadding),
      nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTraits.defaultPadding),
      
      priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
      priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: ViewTraits.defaultPadding),
      priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      priceLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: ViewTraits.contentPadding),
      descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTraits.defaultPadding),
      descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.defaultPadding),
      
      ratingView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: ViewTraits.defaultPadding),
      ratingView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: ViewTraits.contentPadding),
      ratingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      ratingView.heightAnchor.constraint(equalToConstant: ViewTraits.ratingViewHeight),
      ratingView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTraits.ratingViewWidthMultiplier),
      ratingView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
    ])
  }
}
