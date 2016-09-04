//
//  NonPromotedBurgerCell.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 03/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import SDWebImage
import DGActivityIndicatorView

class NonPromotedBurgerCell: UITableViewCell, BurgerCellProtocol {
  
  @IBOutlet weak var imageViewBurger: UIImageView!
  @IBOutlet weak var labelBurgerName: UILabel!
  @IBOutlet weak var labelVegetarian: UILabel!
  @IBOutlet weak var buttonBuy: UIButton!
  var burger: Burger! = nil
  var delegate: BurgerCellDelegate!
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setupCell(burger: Burger) {
    self.burger = burger
    if let image = burger.image {
      let imageURL = NSURL(string: Constants.baseURL + image)
      imageViewBurger.sd_setImageWithURL(imageURL)
    }
    labelBurgerName.text = burger.name
    
    labelVegetarian.hidden = burger.vegetarian == NSNumber(bool: false)
    labelVegetarian.textColor = Constants.Colors.vegetarianGreen
    labelVegetarian.layer.borderColor = Constants.Colors.vegetarianGreen.CGColor
    labelVegetarian.layer.borderWidth = 3.0
    labelVegetarian.layer.cornerRadius = labelVegetarian.frame.size.height / 2.0
    
    if let bitcoin = burger.bitcoin {
      buttonBuy.setTitle("฿" + String(bitcoin), forState: .Normal)
    }
    buttonBuy.addTarget(self, action: #selector(didTapBuyButton), forControlEvents: .TouchUpInside)
    buttonBuy.setuproundedCorneredButton()
  }
  
  func didTapBuyButton() {
      delegate.didBuyBurger(burger)
  }
  
  func getPresentingViewController() -> UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.nextResponder()
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
  
  
}
