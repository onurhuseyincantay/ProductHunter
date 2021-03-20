//
//  ViewControllerProtocol.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import Foundation

protocol ViewControllerProtocol {
  associatedtype ViewModelType: ViewModel
  associatedtype ViewType: BaseView
  
  init(view: ViewType, viewModel: ViewModelType)
}
