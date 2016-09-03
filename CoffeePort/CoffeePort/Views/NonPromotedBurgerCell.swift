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
    self.burger = burger
    if let image = burger.image {
      let imageURL = NSURL(string: Constants.baseURL + image)
      thumbnail.sd_setImageWithURL(imageURL)
    }
    labelBurgerName.text = burger.name
    
    
    let vegeterianGreen = UIColor.init(red: 50.0/255.0, green: 131.0/255.0, blue: 50.0/255.0, alpha: 1)
    labelVegetarian.hidden = burger.vegetarian == NSNumber(bool: false)
    labelVegetarian.textColor = vegeterianGreen
    labelVegetarian.layer.borderColor = vegeterianGreen.CGColor
    labelVegetarian.layer.borderWidth = 3.0
    labelVegetarian.layer.cornerRadius = labelVegetarian.frame.size.height / 2.0
    
    if let bitcoin = burger.bitcoin {
      buttonBuy.setTitle("฿" + String(bitcoin), forState: .Normal)
    }
    buttonBuy.backgroundColor = vegeterianGreen
    buttonBuy.layer.cornerRadius = 4.0
    buttonBuy.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    buttonBuy.addTarget(self, action: #selector(didTapBuyButton), forControlEvents: .TouchUpInside)
    
  }
  
  func didTapBuyButton() {
    
    BurgerAPI.postBurgerRequest(burger.id!, price: burger.bitcoin!) { (result) in
      let alert = UIAlertController(title: result as String, message: nil, preferredStyle: .Alert)
      let closeAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
      alert.addAction(closeAction)
      
      var parentResponder: UIResponder? = self
      while parentResponder != nil {
        parentResponder = parentResponder!.nextResponder()
        if let viewController = parentResponder as? UIViewController {
          viewController.presentViewController(alert, animated: true) {
          }
        }
      }
      
    }
  }

}
