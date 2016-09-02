//
//  AppDelegate.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    MagicalRecord.setupCoreDataStackWithStoreNamed("coffeePort.sqlite")
    DataManager.downloadData()
    MagicalRecord.saveWithBlock({ (localContext) in
      
//      BurgerAPI.getBurgersRequest { (result) in
//        
//      }
//      let burger = Burger.MR_createEntityInContext(localContext)
//      burger.name = "dupa"
      
      })
    
    return true
  }
  
  func applicationWillTerminate(application: UIApplication) {
    MagicalRecord.cleanUp()
  }
  
}

