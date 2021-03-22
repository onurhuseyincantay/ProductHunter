//
//  AddReviewView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

final class AddReviewView: BaseView {
  
  private var containerView: UIView!
  private var ratingView: UIView!
  private var textView: UITextView!
  private var openCloseButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}


// MARK: - Private
private extension AddReviewView {
  
  func setupUIComponents() {
    
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    containerView.layer.cornerRadius = 15
    containerView.clipsToBounds = true
    containerView.backgroundColor = ColorHelper.backgroundWhite
  }
  
  
}

// MARK: - Constraint
private extension AddReviewView {
  
  func addSubviews()  {
    
  }
  
  func setupConstraints() {
    
  }
}
