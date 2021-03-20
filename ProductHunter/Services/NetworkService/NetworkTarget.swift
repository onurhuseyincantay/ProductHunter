//
//  NetworkTarget.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

typealias Parameters = [String : Any]
protocol NetworkTarget {
  var baseURL: URL { get }
  var path: String { get }
  var methodType: MethodType { get }
  var contentType: ContentType { get }
  var workType: WorkType { get }
}

enum MethodType: String {
  case get = "GET"
  case post = "POST"
}

enum WorkType {
  case requestWithBodyParameters(parameters: Parameters)
  case requestWithUrlParameters(parameters: Parameters)
  case requestPlain
}

enum ContentType: String {
  case applicationJson = "application/json"
}
