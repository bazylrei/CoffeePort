//
//  PromotedBurgerView.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 03/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

@IBDesignable

class PromotedBurgerView: UIView {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var burgerName: UILabel!
  @IBOutlet weak var labelVegetarianIndicator: UILabel!
  var burger: Burger?
  
  func setupView(burger: Burger) {
    self.burger = burger
    if let image = burger.image {
      let imageURL = NSURL(string: Constants.baseURL + image)
      imageView.sd_setImageWithURL(imageURL)
    }
    burgerName.text = burger.name
    
    labelVegetarianIndicator.hidden = burger.vegetarian == NSNumber(bool: false)
    labelVegetarianIndicator.textColor = Constants.Colors.vegetarianGreen
    labelVegetarianIndicator.layer.borderColor = Constants.Colors.vegetarianGreen.CGColor
    labelVegetarianIndicator.layer.borderWidth = 3.0
    labelVegetarianIndicator.layer.cornerRadius = labelVegetarianIndicator.frame.size.height / 2.0
    
    
  }
  
}
