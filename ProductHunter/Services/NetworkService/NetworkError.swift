//
//  NetworkError.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

enum NetworkError: Error {
  case unknown
  case sessionError(Error)
  case decodingError(Error)
  case unsucessfulStatusCode(code: Int)
}
