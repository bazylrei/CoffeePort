//
//  ViewController.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BurgerAPI.getBurgersRequest()
        BurgerAPI.postBurgerRequest("2", price: NSNumber(int: 750))
    }

}

