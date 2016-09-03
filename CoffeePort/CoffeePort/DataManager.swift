//
//  DataManager.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import MagicalRecord

class DataManager: NSObject {
  class func downloadData() {
    let arr = Burger.MR_findAll() as! [Burger]
    if arr.count > 0 {
      NSNotificationCenter.defaultCenter().postNotificationName(Constants.dataDownloadedNotification, object: nil)
    }
    BurgerAPI.getBurgersRequest { (result) in
      MagicalRecord.saveWithBlock({ (localContext) in
        for burger in Burger.MR_findAll() {
          burger.MR_deleteEntityInContext(localContext)
        }
        Burger.MR_importFromArray(result, inContext: localContext)
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.dataDownloadedNotification, object: nil)
      })
    }
    
    
  }
}
