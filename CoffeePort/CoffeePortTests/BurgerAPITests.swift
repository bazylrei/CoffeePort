//
//  BurgerAPITests.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 05/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import Quick
import Nimble
import Nocilla
@testable import CoffeePort

class BurgerAPITests: QuickSpec {
    
    override func spec() {
        beforeSuite {
            beforeSuite {LSNocilla.sharedInstance().start()}
            afterSuite {LSNocilla.sharedInstance().stop()}
            afterEach{LSNocilla.sharedInstance().clearStubs()}
            
            describe("BurgerAPI", {
                context("Loading requests") {
                    it("should download 2 items") {
                        let path = NSBundle(forClass: self.dynamicType).pathForResource("burgers", ofType: "json")!
                        let data = NSData(contentsOfFile: path)!
                        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
                        stubRequest("GET", Constants.baseURL + "/burgers/").andReturn(201).withBody(string);
                        
                        BurgerAPI.getBurgersRequest({ (result, error) in })
                        expect(Burger.MR_findAll()!.count).toEventually(equal(2))
                    }
                    it("should get a successful response after posting a burger purchase") {
                        let path = NSBundle(forClass: self.dynamicType).pathForResource("postedBurger", ofType: "json")!
                        let data = NSData(contentsOfFile: path)!
                        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
                        stubRequest("POST", Constants.baseURL + "/burgers/").andReturn(201).withBody(string);
                        
                        var response: NSString?
                        BurgerAPI.postBurgerRequest(NSNumber(int: 5), price: NSNumber(int:555), completion: { (result, error) in
                            response = result
                        })
                        expect(response).toEventually(equal("Order placed."))
                    }
                    
                }
            })
        }
    }
    
}
