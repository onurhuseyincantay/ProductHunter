//
//  ViewModel.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

protocol ViewModel {
  associatedtype ViewControllerType: UIViewController
  
  var delegate: ViewControllerType? { get set }
}





