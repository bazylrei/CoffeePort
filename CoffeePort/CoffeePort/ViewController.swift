//
//  ViewController.swift
//  CoffeePort
//
//  Created by Bazyl Reinstein on 02/09/2016.
//  Copyright © 2016 BazylRei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var burgers: [Burger]! = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
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
      self.burgers = Burger.MR_findAll() as! [Burger]!
      self.tableView.reloadData()
    })
  }
  
}

// MARK: UITableViewDataSource

extension ViewController {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return burgers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Constants.burgerCellIdentifier, forIndexPath: indexPath) as! NonPromotedBurgerCell
    cell.setupCell(burgers[indexPath.row])
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
    let note = burgers[indexPath.row].notes
    let alert = UIAlertController(title: "Notes", message: note, preferredStyle: .Alert)
    let closeAction = UIAlertAction(title: "Close", style: .Cancel, handler: nil)
    alert.addAction(closeAction)
    self.presentViewController(alert, animated: true) {
      
    }
  }
}
