//
//  ViewControllerProtocol.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ViewControllerProtocol: UIViewController {
  associatedtype ViewModelType: ViewModel
  associatedtype ViewType: BaseView
  
  init(view: ViewType, viewModel: ViewModelType)
}
