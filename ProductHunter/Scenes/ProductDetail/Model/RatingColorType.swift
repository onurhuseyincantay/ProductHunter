//
//  RatingColorType.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import UIKit

enum RatingColorType: Int {
  case veryLow = 1
  case low
  case normal
  case good
  case perfect
  
  func getBackgroundColor() -> UIColor {
    switch self {
    case .veryLow:
      return ColorHelper.veryLowRating
      
    case .low:
      return ColorHelper.lowRating
      
    case .normal:
      return ColorHelper.normalRating
      
    case .good:
      return ColorHelper.goodRating
      
    case .perfect:
      return ColorHelper.perfectRating
    }
  }
}
