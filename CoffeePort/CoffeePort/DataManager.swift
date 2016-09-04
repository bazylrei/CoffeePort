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
  class func downloadData(completionBlock: (success: Bool, message: String) -> Void) {
    var reachability: Reachability!
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Reachability has encountered an error")
    }
    if !reachability.isReachable() {
      completionBlock(success: false, message:"There is no internet connection")
      return
    } else {
      BurgerAPI.getBurgersRequest { (result, error) in
        if error != nil {
          completionBlock(success: false, message: "Something went wrong")
        }
        MagicalRecord.saveWithBlock({ (localContext) in
          for burger in Burger.MR_findAll() {
            burger.MR_deleteInContext(localContext)
          }
        }, completion: { (booleanResult, error) in
            MagicalRecord.saveWithBlock({ (localContext) in
              Burger.MR_importFromArray(result, inContext: localContext)
            }, completion: { (s, error) in
              completionBlock(success: true, message:"Success")
            })
        })
      }
    }
  }
}
