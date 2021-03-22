//
//  AddReviewView.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import UIKit

protocol AddReviewViewDelegate: BaseView {
  func didPressOpenCloseButton(isExpanding: Bool)
  func keyboardDidShow(isShowing: Bool, keyboardHeight: CGFloat)
  func didSendReview(reviewText: String, rating: Int)
}

final class AddReviewView: BaseView {
  weak var delegate: AddReviewViewDelegate?
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 16
    static let contentPadding: CGFloat = 8
    static let ratingViewHeight: CGFloat = 24
    static let textViewHeight: CGFloat = 200
  }
  
  static let textViewTopPadding: CGFloat = ViewTraits.ratingViewHeight + ViewTraits.defaultPadding + ViewTraits.contentPadding
  static let totalContainerHeigt: CGFloat = ViewTraits.textViewHeight + AddReviewView.generalVerticalPadding
  static let generalVerticalPadding = (ViewTraits.defaultPadding * 2) + ViewTraits.contentPadding
  
  private var sendReviewLabel: UILabel!
  private var containerView: UIView!
  private var ratingView: RatingView!
  private var textView: UITextView!
  private var openCloseButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
    addKeybooardObservers()
  }
  
  deinit {
    removeKeyboardObservers()
  }
}

// MARK: - UITextViewDelegate
extension AddReviewView: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard text == "\n" else {
      return true
    }
    delegate?.didSendReview(reviewText: text, rating: ratingView.getRatingAmount())
    clearFields()
    return true
  }
}

@objc private extension AddReviewView {
  
  func didPressOpenCloseButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    delegate?.didPressOpenCloseButton(isExpanding: sender.isSelected)
    guard !openCloseButton.isSelected else {
      return
    }
    clearFields()
  }
  
  func keyboardWillShow(sender: NSNotification) {
    let value = sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    delegate?.keyboardDidShow(isShowing: true, keyboardHeight: value.cgRectValue.height)
  }

  func keyboardWillHide(sender: NSNotification) {
    let value = sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    delegate?.keyboardDidShow(isShowing: false, keyboardHeight: value.cgRectValue.height)
  }
}


// MARK: - Private
private extension AddReviewView {
  
  func setupUIComponents() {
    setupContainerView()
    setupSendReviewLabel()
    setupTextView()
    setupOpenCloseButton()
    setupRatingView()
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    containerView.layer.cornerRadius = 15
    containerView.clipsToBounds = true
    containerView.backgroundColor = .white
  }
  
  func setupRatingView() {
    ratingView = RatingView()
  }
  
  func setupTextView() {
    textView = UITextView()
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.textColor = .black
    textView.layer.cornerRadius = 15
    textView.clipsToBounds = true
    textView.delegate = self
    textView.returnKeyType = .send
    textView.backgroundColor = ColorHelper.backgroundWhite
    textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  
  func setupOpenCloseButton() {
    openCloseButton = UIButton()
    openCloseButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    openCloseButton.setTitle("Open", for: .normal)
    openCloseButton.setTitle("Close", for: .selected)
    openCloseButton.setTitleColor(.black, for: .normal)
    openCloseButton.setTitleColor(.black, for: .selected)
    openCloseButton.addTarget(self, action: #selector(didPressOpenCloseButton), for: .touchUpInside)
  }
  
  func setupSendReviewLabel() {
    sendReviewLabel = UILabel()
    sendReviewLabel.font = .systemFont(ofSize: 16, weight: .bold)
    sendReviewLabel.textColor = .black
    sendReviewLabel.text = "Send Review"
  }
  
  func clearFields() {
    textView.resignFirstResponder()
    textView.text = ""
    ratingView.clearRatings()
    openCloseButton.isSelected = false
  }
  
  func addKeybooardObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func removeKeyboardObservers() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

// MARK: - Constraint
private extension AddReviewView {
  
  func addSubviews()  {
    addSubviewWC(containerView)
    
    containerView.addSubviewWC(sendReviewLabel)
    containerView.addSubviewWC(openCloseButton)
    containerView.addSubviewWC(ratingView)
    containerView.addSubviewWC(textView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    setupContainerConstraints()
  }
  
  func setupContainerConstraints() {
    NSLayoutConstraint.activate([
      
      sendReviewLabel.topAnchor.constraint(equalTo: openCloseButton.topAnchor),
      sendReviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.defaultPadding),
      sendReviewLabel.trailingAnchor.constraint(equalTo: openCloseButton.leadingAnchor),
      sendReviewLabel.bottomAnchor.constraint(equalTo: openCloseButton.bottomAnchor),
      
      openCloseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.defaultPadding),
      openCloseButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      
      ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AddReviewView.textViewTopPadding),
      ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.contentPadding),
      ratingView.trailingAnchor.constraint(equalTo: openCloseButton.leadingAnchor, constant: -ViewTraits.contentPadding),
      ratingView.heightAnchor.constraint(equalToConstant: ViewTraits.ratingViewHeight),
      
      textView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: ViewTraits.contentPadding),
      textView.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: openCloseButton.trailingAnchor),
      textView.heightAnchor.constraint(equalToConstant: ViewTraits.textViewHeight),
      textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.defaultPadding)
    ])
  }
}



