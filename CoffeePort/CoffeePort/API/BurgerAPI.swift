//
//  BurgerAPI.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import Alamofire
import MagicalRecord

class BurgerAPI: NSObject {
  
    class func getBurgersRequest(completion: (result: [AnyObject], error: String?) -> Void) {
    Alamofire.request(.GET, Constants.baseURL + "/burgers/")
      .responseJSON { response in
        switch response.result {
        case .Success:
          guard let JSON = response.result.value else { return }
          
          let burgers = JSON.objectForKey("burgers")
          if let burgers = burgers {
            completion(result: burgers as! [AnyObject], error: nil)
          }
          break
        case .Failure:
            completion(result: [], error: "something went wrong")
        }
    }
  }
  
  class func postBurgerRequest(burgerID: NSNumber, price: NSNumber, completion: (result: NSString, error: NSString?) -> Void) {
    let parameters = [
      "id": burgerID,
      "bitcoin": price
    ]
    
    Alamofire.request(.POST, Constants.baseURL + "/burgers/", parameters: parameters)
      .responseJSON { response in
        
        switch response.result {
        case .Success:
          if let JSON = response.result.value {
            print("JSON: \(JSON)")
            if let message = JSON.objectForKey("message") as? NSString {
              
              completion(result: message, error: nil)
            }
          }
          break
        case .Failure:
          completion(result: "an error occured", error: "Error")
          break
        }
    }
  }
  
}
