//
//  BaseViewController.swift
//  ProductHunter
//
//  Created by Onur Hüseyin Çantay on 20.03.2021.
//

import UIKit

class BaseViewController: UIViewController {
  var isNavigationBarHiddden: Bool = true
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(isNavigationBarHiddden, animated: true)
  }
}
