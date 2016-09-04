//
//  ViewController.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit
import DGActivityIndicatorView
import ReachabilitySwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BurgerCellDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var labelNoBurgers: UILabel!
  var promotedBurgers: [Burger]! = []
  var nonPromotedBurgers: [Burger]! = []
  var activityIndicator: DGActivityIndicatorView!
  let refreshControl =  UIRefreshControl()
  var reachability: Reachability!
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.presentActivityIndicator()
    
    refreshControl.backgroundColor = UIColor.whiteColor()
    refreshControl.tintColor = UIColor.redColor()
    refreshControl.addTarget(self, action: #selector(downloadData), forControlEvents: .ValueChanged)
    tableView.addSubview(refreshControl)
    
    setupReachability()
    
    labelNoBurgers.hidden = true
    let arr = Burger.MR_findAll() as! [Burger]
    if arr.count > 0 {
      reloadData()
    }
    downloadData()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  //MARK: Data loading
  
  func reloadData() {
    dispatch_async(dispatch_get_main_queue(),{
      self.hideActivityIndicator()
      self.refreshControl.endRefreshing()
      
      let allBurgers = Burger.MR_findAll() as! [Burger]
      print(allBurgers.count)
      self.nonPromotedBurgers = allBurgers.filter({ (burger) -> Bool in
        return burger.promoted == NSNumber(bool: false)
      })
      self.nonPromotedBurgers = self.nonPromotedBurgers.sort{ return $0.id?.intValue < $1.id?.intValue}
      
      self.promotedBurgers = allBurgers.filter({ (burger) -> Bool in
        return burger.promoted == NSNumber(bool: true)
      })
       self.promotedBurgers = self.promotedBurgers.sort{ return $0.id?.intValue < $1.id?.intValue}
      
      
      self.setupScrollView()
      self.tableView.reloadData()
    })
  }
  
  func downloadData() {
    
    DataManager.downloadData { (success, message) in
      if !success {
        let controller = UIAlertController(title: message, message: "Please try again later", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        controller.addAction(action)
        self.presentViewController(controller, animated: true, completion: nil)
        self.refreshControl.endRefreshing()
        self.activityIndicator.hidden = true
        if Burger.MR_findAll().count == 0 {
          self.labelNoBurgers.hidden = false
        }
      } else {
        self.reloadData()
      }
    }
  }
  
  func setupReachability() {
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Reachability has encountered an error")
    }
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(downloadData), name: Constants.Notifications.ReachabilityChangedNotification, object: nil)
    do {
      try reachability.startNotifier()
    } catch {
      print("could not start reachability notifier")
    }
    
  }
  
  func presentActivityIndicator(hidingBackground hidingBackround: Bool = true) {
    if hidingBackround == true {
      tableView.hidden = true
      tableView.alpha = 0.0
      
      scrollView.hidden = true
      scrollView.alpha = 0.0
    }
    
    activityIndicator = DGActivityIndicatorView(type: .LineScalePulseOut, tintColor: UIColor.redColor())
    activityIndicator.frame = CGRectMake(0,
                                         0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)
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
  
  func setupScrollView() {
    scrollView.pagingEnabled = true
    scrollView.alwaysBounceVertical = false
    for i in 0..<promotedBurgers.count {
      let xOrigin = CGFloat(i) * scrollView.frame.size.width
      var frame = self.scrollView.bounds
      frame.origin.x = xOrigin
      let burger = promotedBurgers[i]
      let allViewsInXibArray = NSBundle.mainBundle().loadNibNamed("PromotedBurgerView", owner: self, options: nil)
      let burgerView = allViewsInXibArray.first as! PromotedBurgerView
      burgerView.frame = frame
      burgerView.setupView(burger)
      burgerView.delegate = self
      scrollView.addSubview(burgerView)
    }
    
    let width = scrollView.frame.size.width * CGFloat(promotedBurgers.count)
    let height = scrollView.frame.size.height
    scrollView.contentSize = CGSizeMake(width, height)
    
  }
  
}

// MARK: BurgerCellDelegate

extension ViewController {
  func didBuyBurger(burger: Burger!) {
    if reachability.isReachable() {
      presentActivityIndicator(hidingBackground: false)
      DataManager.postBurgerRequest(burger.id!, price: burger.bitcoin!) { (result, error) in
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
        let alert = UIAlertController(title: burger.name!,
                                      message: result as String,
                                      preferredStyle: .Alert)
        let closeAction = UIAlertAction(title: "Ok",
                                        style: .Cancel,
                                        handler: nil)
        alert.addAction(closeAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
      }
    }
  }
  
  func didTapBurgerCell(burger: Burger!) {
    let note = burger.notes
    let alert = UIAlertController(title: "Notes", message: note, preferredStyle: .Alert)
    let closeAction = UIAlertAction(title: "Close", style: .Cancel, handler: nil)
    alert.addAction(closeAction)
    self.presentViewController(alert, animated: true) {
    }
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
    cell.delegate = self
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
    let burger = self.nonPromotedBurgers[indexPath.row]
    self.didTapBurgerCell(burger)
  }
}
