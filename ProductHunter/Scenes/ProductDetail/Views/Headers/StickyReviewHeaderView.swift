//
//  StickyReviewHeaderView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

final class StickyReviewHeaderView: BaseView {
  private var titleLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Public
extension StickyReviewHeaderView {
  
  func setText(_ text: String) {
    titleLabel.text = text
  }
}

// MARK: - Private
private extension StickyReviewHeaderView {
  
  func setupUIComponents() {
    backgroundColor = ColorHelper.backgroundWhite
    backgroundColor = .white
    setupTitleLabel()
  }
  
  func setupTitleLabel() {
    titleLabel = UILabel()
    titleLabel.numberOfLines = 2
    titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
  }
}

// MARK: - Constraints
private extension StickyReviewHeaderView {
  
  func addSubviews() {
    addSubviewWC(titleLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}
