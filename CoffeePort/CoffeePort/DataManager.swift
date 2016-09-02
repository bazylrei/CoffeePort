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
    for burger in arr {
      print(burger.name)
    }
    BurgerAPI.getBurgersRequest { (result) in
      MagicalRecord.saveWithBlock({ (localContext) in
        Burger.MR_importFromArray(result, inContext: localContext)
      })
    }
    
    
  }
}
