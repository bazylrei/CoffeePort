//
//  Constants.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 03/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

struct Constants {
  struct Notifications {
    static let dataDownloadedNotification = "coffeePort.dataDownloadedNotification"
    static let ReachabilityChangedNotification = "ReachabilityChangedNotification"
  }
  struct Colors {
    static let vegetarianGreen = UIColor.init(red: 50.0/255.0, green: 131.0/255.0, blue: 50.0/255.0, alpha: 1)
  }
  static let burgerCellIdentifier = "BurgerCell"
  static let baseURL = "http://coffeeport.herokuapp.com"
}