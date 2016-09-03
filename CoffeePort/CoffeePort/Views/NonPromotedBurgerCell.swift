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
    
    labelVegetarian.hidden = burger.vegetarian == NSNumber(bool: false)
    labelVegetarian.textColor = Constants.Colors.vegetarianGreen
    labelVegetarian.layer.borderColor = Constants.Colors.vegetarianGreen.CGColor
    labelVegetarian.layer.borderWidth = 3.0
    labelVegetarian.layer.cornerRadius = labelVegetarian.frame.size.height / 2.0
    
    if let bitcoin = burger.bitcoin {
      buttonBuy.setTitle("฿" + String(bitcoin), forState: .Normal)
    }
    buttonBuy.addTarget(self, action: #selector(didTapBuyButton), forControlEvents: .TouchUpInside)
    self.drawButton()
  }
  
  func drawButton() {
    var token: dispatch_once_t = 0
    dispatch_once(&token) {
      self.buttonBuy.backgroundColor = Constants.Colors.vegetarianGreen
      self.buttonBuy.layer.cornerRadius = 4.0
      self.buttonBuy.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      
    }
  }
  
  func didTapBuyButton() {
    guard let viewController = self.getPresentingViewController() else { return }
    
    let activityIndicator = DGActivityIndicatorView(type: .LineScalePulseOut, tintColor: UIColor.redColor()) // (type: .LineScalePulseOut,
    activityIndicator.frame = CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)
    activityIndicator.center = viewController.view.center
    viewController.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    
    BurgerAPI.postBurgerRequest(burger.id!, price: burger.bitcoin!) { (result) in
      activityIndicator.stopAnimating()
      activityIndicator.removeFromSuperview()
      let alert = UIAlertController(title: self.burger.name!, message: result as String, preferredStyle: .Alert)
      let closeAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
      alert.addAction(closeAction)
      
      viewController.presentViewController(alert, animated: true, completion: nil)
      
    }
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
