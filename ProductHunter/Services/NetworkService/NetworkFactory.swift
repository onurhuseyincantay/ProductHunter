//
//  NetworkFactory.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Hover

typealias NetworkManager = Hover

enum NetworkFactory {
  
  static func makeNetworkManager() -> NetworkManager {
    Hover()
  }
}
