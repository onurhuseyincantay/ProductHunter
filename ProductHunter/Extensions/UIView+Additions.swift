//
//  UIView+Additions.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

extension UIView {
  
  /// sets translatesAutoresizingMaskIntoConstraints to ´False´ and calls ´addSubview´
  func addSubviewWC(_ view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
  }
}
