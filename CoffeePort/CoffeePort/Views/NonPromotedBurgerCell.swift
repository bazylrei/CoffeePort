//
//  NonPromotedBurgerCell.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 03/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import SDWebImage

class NonPromotedBurgerCell: UITableViewCell {

  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var labelBurgerName: UILabel!
  @IBOutlet weak var labelVegetarian: UILabel!
  @IBOutlet weak var buttonBuy: UIButton!
  var burger: Burger! = nil

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setupCell(burger: Burger) {
//    burger = burger
    if let image = burger.image {
      let imageURL = NSURL(string: Constants.baseURL + image)
      thumbnail.sd_setImageWithURL(imageURL)
    }
    labelBurgerName.text = burger.name
    labelVegetarian.text = burger.vegetarian == NSNumber(bool: true) ? "V" : ""
    buttonBuy.setTitle(String(burger.bitcoin), forState: .Normal)
  }

}
