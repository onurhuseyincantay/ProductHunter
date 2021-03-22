//
//  CGFloat+Additions.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 22.03.2021.
//

import UIKit

extension CGFloat {
  
  func getRangeAndIsHalfValue() -> (range: Range<Int>, isHalfValue: Bool) {
    let nearest: CGFloat = 0.5
    let rounded = round(nearest: nearest)
    let hasHalf = self - rounded == nearest
    
    if hasHalf {
      return ((0..<Int(floor(self))), hasHalf)
    } else {
      return ((0..<Int(ceil(self))), hasHalf)
    }
  }
  
  func round(nearest: CGFloat) -> CGFloat {
      let n = 1/nearest
      let numberToRound = self * n
      return numberToRound.rounded() / n
  }
}
