//
//  Product.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

typealias ProductList = [Product]

// MARK: - Product
struct Product: Codable {
    let currency: String
    let price: Int
    let id: String?
    var name: String?
    var description: String?
    let imgURL: URL?
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case currency, price, id, name, description, reviews
        case imgURL = "imgUrl"
    }
}
