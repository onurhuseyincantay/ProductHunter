//
//  URL+Additions.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

extension URL {
    func generateUrlWithQuery(with parameters: [String: Any]) -> URL {
        var quearyItems: [URLQueryItem] = []
        for parameter in parameters {
            quearyItems.append(URLQueryItem(name: parameter.key, value: parameter.value as? String))
        }
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = quearyItems
        guard let url = urlComponents.url else { fatalError("Wrong URL Provided") }
        return url
    }
}
