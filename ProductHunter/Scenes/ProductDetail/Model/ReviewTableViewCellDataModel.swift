//
//  ReviewTableViewCellDataModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 21.03.2021.
//

import Foundation

typealias ReviewTableViewDataSource =  [ReviewTableViewCellDataModel]

struct ReviewTableViewCellDataModel {
  let locale: Locale
  let review: String
  let rating: Int
}

extension ReviewTableViewCellDataModel {
  
  func getBackgroundColorName() -> String {
    var name: String
    if (0...1).contains(rating) {
      name = "veryLowRating"
    } else if (1...2).contains(rating) {
      name = "lowRating"
    } else if (2...3).contains(rating) {
      name = "normalRating"
    } else if (3...4).contains(rating) {
      name = "goodRating"
    } else {
      name = "perfectRating"
    }
    return name
  }
  
  func getLocaleFlag() -> String {
    switch locale {
    case .enUS:
      return "🇺🇸"
    }
  }
}
