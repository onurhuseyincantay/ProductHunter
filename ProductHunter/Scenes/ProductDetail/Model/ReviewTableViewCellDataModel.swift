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
  
  func getLocaleFlag() -> String {
    switch locale {
    case .enUS:
      return "🇺🇸"
    }
  }
}
