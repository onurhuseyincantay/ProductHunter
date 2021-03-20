//
//  Review.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

// MARK: - Review
struct Review: Codable {
    let productID: String
    let locale: Locale
    let rating: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case locale, rating, text
    }
}

enum Locale: String, Codable {
    case enUS = "en-US"
}

