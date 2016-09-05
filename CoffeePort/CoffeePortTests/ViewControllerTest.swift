//
//  ViewControllerTest.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 05/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import XCTest

import Nocilla
@testable import CoffeePort

class ViewControllerTest: XCTestCase {
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        LSNocilla.sharedInstance().start()
        let path = NSBundle(forClass: self.dynamicType).pathForResource("burgers", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        stubRequest("GET", Constants.baseURL + "/burgers/").andReturn(201).withBody(string);
//        stub(uri(Constants.baseURL + "/burgers/"), builder: jsonData(data))

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let _ = viewController.view
        viewController.loadView()
    }
    
//    override func tearDown() {
//        super.tearDown()
////        LSNocilla.sharedInstance().stop()
//    }
//    
    func testDelegate() {
        XCTAssert((viewController.tableView.delegate?.isEqual(viewController))!, "tableViews delegate should be the viewController")
    }
    
    func testDataSource() {
        XCTAssert((viewController.tableView.dataSource?.isEqual(viewController))!, "tableViews datasource should be the viewController")
    }

    
}
