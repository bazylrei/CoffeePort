//
//  BuyButton.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 04/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

extension UIButton {
  func setuproundedCorneredButton() {
    var token: dispatch_once_t = 0
    dispatch_once(&token) {
      self.backgroundColor = Constants.Colors.vegetarianGreen
      self.layer.cornerRadius = 4.0
      self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      
    }
  }
}