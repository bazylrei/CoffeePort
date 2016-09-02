//
//  BurgerAPI.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import Alamofire

class BurgerAPI: NSObject {

    class func getBurgersRequest() {
        Alamofire.request(.GET, "http://coffeeport.herokuapp.com/burgers/", parameters: ["foo": "bar"])
            .responseJSON { response in
                
                guard let JSON = response.result.value else {
                    return
                }
                
                let burgers = JSON.objectForKey("burgers")
                if let burgers = burgers {
                    let burgerObjects = Burger.MR_importFromArray(burgers as! [AnyObject])
                    print(burgerObjects)
                }
        }
    }
    
    class func postBurgerRequest(burgerID: String, price: NSNumber) {
        let parameters = [
            "id": burgerID,
            "bitcoin": price
        ]
        
        Alamofire.request(.POST, "http://coffeeport.herokuapp.com/burgers/", parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
}
