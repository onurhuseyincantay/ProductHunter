//
//  Identifiable.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    String(describing: Self.self)
  }
}


extension UITableViewCell: Identifiable { }

