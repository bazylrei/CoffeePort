//
//  ViewController.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import DGActivityIndicatorView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scrollView: UIScrollView!
  var promotedBurgers: [Burger]! = []
  var nonPromotedBurgers: [Burger]! = []
  var activityIndicator: DGActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.presentActivityIndicator()
    
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector:#selector(reloadData) ,
                                                     name: Constants.dataDownloadedNotification,
                                                     object: nil)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func reloadData() {
    dispatch_async(dispatch_get_main_queue(),{
      self.hideActivityIndicator()
      self.nonPromotedBurgers = Burger.MR_findAllWithPredicate(NSPredicate(format: "promoted = %@", NSNumber(bool: false))) as! [Burger]!
      self.tableView.reloadData()
    })
  }
  
  func presentActivityIndicator() {
    tableView.hidden = true
    tableView.alpha = 0.0
    
    scrollView.hidden = true
    scrollView.alpha = 0.0
    
    activityIndicator = DGActivityIndicatorView(type: .LineScalePulseOut, tintColor: UIColor.redColor())
    activityIndicator.frame = CGRectMake(0, 0, 50, 50)
    activityIndicator.center = self.view.center
    self.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
  
  func hideActivityIndicator() {
    tableView.hidden = false
    scrollView.hidden = false
    UIView.animateWithDuration(0.25) {
      self.tableView.alpha = 1.0
      self.scrollView.alpha = 1.0
    }
    
    self.activityIndicator.removeFromSuperview()
  }
  
}

// MARK: UITableViewDataSource

extension ViewController {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nonPromotedBurgers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.burgerCellIdentifier, forIndexPath: indexPath) as! NonPromotedBurgerCell
    cell.setupCell(nonPromotedBurgers[indexPath.row])
    cell.backgroundColor = UIColor.lightTextColor()//colors[indexPath.row % 2]
    return cell
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
}

// MARK: UITableViewDelegate

extension ViewController {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    let note = nonPromotedBurgers[indexPath.row].notes
    let alert = UIAlertController(title: "Notes", message: note, preferredStyle: .Alert)
    let closeAction = UIAlertAction(title: "Close", style: .Cancel, handler: nil)
    alert.addAction(closeAction)
    self.presentViewController(alert, animated: true) {
      
    }
  }
}
