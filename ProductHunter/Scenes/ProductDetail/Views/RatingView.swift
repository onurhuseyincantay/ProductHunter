//
//  RatingView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

final class RatingView: BaseView {
  private var stackView: UIStackView!
  private var starButtons: [UIButton]!
  
  var isButtonStackViewSelectable: Bool = false {
    didSet {
      stackView.isUserInteractionEnabled = isButtonStackViewSelectable
    }
  }
  
  private enum ViewTraits {
    static let totalStarButtonCount: Int = 5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Public
extension RatingView {
  
  func updateRating(amount: CGFloat) {
    let (range, isHalfValue) = amount.getRangeAndIsHalfValue()
    selectButtons(in: range)
    if isHalfValue {
      starButtons[range.upperBound - 1].setImage(AssetHelper.halfFilledStarImage, for: .normal)
    }
    setTintColor(for: range.upperBound)
  }
}

// MARK: - Selector
@objc private extension RatingView {
  
  func didSelectButton(_ sender: UIButton) {
    let closedRange: Range<Int> = (0..<sender.tag + 1)
    selectButtons(in: closedRange)
  }
}


private extension RatingView {
  
  func setupUIComponents() {
    setupStarButtons()
    setupStackView()
  }
  
  func setupStackView() {
    stackView = UIStackView(arrangedSubviews: starButtons)
    stackView.alignment = .fill
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.isUserInteractionEnabled = isButtonStackViewSelectable
  }
  
  func setupStarButtons() {
    starButtons = []
    for x in 0..<ViewTraits.totalStarButtonCount {
      let button = setupStarButton()
      button.tag = x
      starButtons.append(button)
    }
  }
  
  func setupStarButton() -> UIButton {
    let button = UIButton()
    button.setImage(AssetHelper.emptyStarImage, for: .normal)
    button.setImage(AssetHelper.filledStarImage, for: .selected)
    button.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
    button.tintColor = ColorHelper.backgroundWhite
    return button
  }
  
  func selectButtons(in range: Range<Int>) {
    range.forEach {
      starButtons[$0].isSelected = true
    }
    guard range.upperBound != ViewTraits.totalStarButtonCount else {
      return
    }
    let rightRange = (range.upperBound..<ViewTraits.totalStarButtonCount)
    rightRange.forEach {
      starButtons[$0].isSelected = false
    }
  }
  
  func setTintColor(for rangeUpperBound: Int) {
    guard let type = RatingColorType(rawValue: rangeUpperBound) else {
      return
    }
    starButtons.forEach { $0.tintColor = type.getBackgroundColor() }
  }
  

}

// MARK: - Constraints
private extension RatingView {
  
  func addSubviews() {
    addSubviewWC(stackView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}

extension CGFloat {
  
  func getRangeAndIsHalfValue() -> (range: Range<Int>, isHalfValue: Bool) {
    let nearest: CGFloat = 0.5
    let rounded = self.round(nearest: nearest)
    let hasHalf = self - rounded == nearest
    
    if hasHalf {
      return ((0..<Int(floor(self))), hasHalf)
    } else {
      return ((0..<Int(ceil(self))), hasHalf)
    }
  }
}


extension CGFloat {
    func round(nearest: CGFloat) -> CGFloat {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
