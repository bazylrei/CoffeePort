//
//  DataManager.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import MagicalRecord
import ReachabilitySwift

class DataManager: NSObject {
  class func downloadData() {
    
    
    var reachability: Reachability!
    do {
       reachability = try Reachability.reachabilityForInternetConnection()
    }  catch {
      print("error getting reachability")
    }
    
    let arr = Burger.MR_findAll() as! [Burger]
    if arr.count > 0 {
      NSNotificationCenter.defaultCenter().postNotificationName(Constants.dataDownloadedNotification, object: nil)
    }
    if reachability.isReachable() {
      BurgerAPI.getBurgersRequest { (result) in
        MagicalRecord.saveWithBlock({ (localContext) in
          for burger in Burger.MR_findAll() {
            burger.MR_deleteInContext(localContext)
          }
          }, completion: { (booleanResult, error) in
            MagicalRecord.saveWithBlock({ (localContext) in
              Burger.MR_importFromArray(result, inContext: localContext)
              }, completion: { (booleanResult, error) in
                NSNotificationCenter.defaultCenter().postNotificationName(Constants.dataDownloadedNotification, object: nil)
            })
        })
        
      }
    } else {
      NSNotificationCenter.defaultCenter().postNotificationName(Constants.dataDownloadedNotification, object: nil)
    }
    
  }
}
