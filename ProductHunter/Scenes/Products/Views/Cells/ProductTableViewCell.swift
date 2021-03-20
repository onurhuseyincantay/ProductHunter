//
//  ProductTableViewCell.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
  private var containerView: UIView!
  private var productImageView: UIImageView!
  private var titleLabel: UILabel!
  private var descriptionLabel: UILabel!
  private var priceLabel: UILabel!
  
  enum ViewTrait {
    static let defaultPadding: CGFloat = 16
    static let contentPadding: CGFloat = 8
    static let productImageViewWidthMultiplier: CGFloat = 0.3
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Public
extension ProductTableViewCell {
  func prepareCell(with model: ProductTableViewCellModel) {
    titleLabel.text = model.title
    descriptionLabel.text = model.description
    priceLabel.text = model.price
    if let url = model.imageUrl {
      productImageView.setCachedImage(from: url, placeholder: AssetHelper.productPlaceHolderImage, isTemplate: false)
    }
  }
}

// MARK: - Private
private extension ProductTableViewCell {
  
  func setupUIComponents() {
    backgroundColor = .clear
    selectionStyle = .none
    setupContainerView()
    setupProductImageView()
    setupTitleLabel()
    setupDescriptionLabel()
    setupPriceLabel()
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.backgroundColor = ColorHelper.backgroundWhite
    containerView.layer.cornerRadius = 15
    containerView.clipsToBounds = true
  }
  
  func setupProductImageView() {
    productImageView = UIImageView()
    productImageView.contentMode = .scaleAspectFit
    productImageView.image = AssetHelper.productPlaceHolderImage
  }
  
  func setupTitleLabel() {
    titleLabel = UILabel()
    titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    titleLabel.textColor = .black
  }
  
  func setupDescriptionLabel() {
    descriptionLabel = UILabel()
    descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
    descriptionLabel.textColor = .darkGray
  }
  
  func setupPriceLabel() {
    priceLabel = UILabel()
    priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    priceLabel.textColor = .green
  }
}

// MARK: - Constraints
private extension ProductTableViewCell {
  
  func addSubviews() {
    contentView.addSubviewWC(containerView)
    
    containerView.addSubviewWC(productImageView)
    containerView.addSubviewWC(titleLabel)
    containerView.addSubviewWC(descriptionLabel)
    containerView.addSubviewWC(priceLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTrait.defaultPadding),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTrait.defaultPadding),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTrait.defaultPadding),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTrait.defaultPadding),
    ])
    setupContainerViewConstraints()
  }
  
  func setupContainerViewConstraints() {
    NSLayoutConstraint.activate([
      productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      productImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTrait.productImageViewWidthMultiplier),
      productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
      productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTrait.defaultPadding),
      titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: ViewTrait.defaultPadding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.defaultPadding),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTrait.contentPadding),
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      
      priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: ViewTrait.contentPadding),
      priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTrait.defaultPadding)
    ])
  }
}


struct ProductTableViewCellModel {
  let imageUrl: URL?
  let title: String?
  let description: String?
  let price: String?
}



