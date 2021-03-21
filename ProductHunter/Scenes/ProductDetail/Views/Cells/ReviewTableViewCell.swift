//
//  ReviewTableViewCell.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
  
  private var containerView: UIView!
  private var localeLabel: UILabel!
  private var ratingView: RatingView!
  private var reviewLabel: UILabel!
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 16
    static let contentPadding: CGFloat = 8
    static let ratingViewHeight: CGFloat = 32
    static let ratingViewWidthMultiplier: CGFloat = 0.4
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
extension ReviewTableViewCell {
  
  func prepareCell(with model: ReviewTableViewCellDataModel) {
    containerView.backgroundColor = UIColor(named: model.getBackgroundColorName())?.withAlphaComponent(0.1)
    localeLabel.text = model.getLocaleFlag()
    reviewLabel.text = model.review
  }
}

// MARK: - Private
private extension ReviewTableViewCell {
  
  func setupUIComponents() {
    contentView.backgroundColor = .clear
    backgroundColor = .clear
    selectionStyle = .none
    
    setupContainerView()
    setupLocaleLabel()
    setupRatingView()
    setupReviewLabel()
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.clipsToBounds = true
    contentView.layer.cornerRadius = 5
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.white.cgColor
  }
  
  func setupLocaleLabel() {
    localeLabel = UILabel()
  }
  
  func setupRatingView() {
    ratingView = RatingView()
    ratingView.backgroundColor = .orange
  }
  
  func setupReviewLabel() {
    reviewLabel = UILabel()
    reviewLabel.font = .systemFont(ofSize: 14, weight: .bold)
    reviewLabel.textColor = .black
    reviewLabel.numberOfLines = 0
  }
}

// MARK: - Constraints
private extension ReviewTableViewCell {
  
  func addSubviews() {
    contentView.addSubviewWC(containerView)
    
    containerView.addSubviewWC(localeLabel)
    containerView.addSubviewWC(ratingView)
    containerView.addSubviewWC(reviewLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.defaultPadding),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.defaultPadding),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.defaultPadding),
    ])
    setupContainerConstraints()
  }
  
  func setupContainerConstraints() {
    NSLayoutConstraint.activate([
      localeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.contentPadding),
      localeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.contentPadding),
      
      
      ratingView.topAnchor.constraint(equalTo: localeLabel.topAnchor),
      ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.contentPadding),
      ratingView.heightAnchor.constraint(equalToConstant: ViewTraits.ratingViewHeight),
      ratingView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTraits.ratingViewWidthMultiplier),
      
      reviewLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: ViewTraits.contentPadding),
      reviewLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
      reviewLabel.trailingAnchor.constraint(equalTo: localeLabel.trailingAnchor),
      reviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.contentPadding)
    ])
  }
}
