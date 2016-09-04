//
//  BurgerCellProtocol.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 04/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

protocol BurgerCellProtocol {
  weak var imageViewBurger: UIImageView! {get set}
  weak var labelBurgerName: UILabel! {get set}
  weak var labelVegetarian: UILabel! {get set}
  weak var buttonBuy: UIButton! {get set}
}

protocol BurgerCellDelegate {
  func didBuyBurger(burger: Burger!)
  func didTapBurgerCell(burger: Burger!)
}
