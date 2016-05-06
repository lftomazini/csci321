//
//  GraphViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/19/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit


///
/// View that contains the expenses added and the graph displaying them
///
class GraphViewController: UIViewController, UITableViewDataSource {
    //Insert below the tableView IBOutlet
    var expenses = [Expenses]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerClass(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
        
        // creates 3d-touch shortcut for add item
        let add = UIApplicationShortcutItem(type: "addItem", localizedTitle: "Add Item", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .Add), userInfo: nil)
        
        // adds shortcuts to homescreen
        UIApplication.sharedApplication().shortcutItems = [add]
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNew(sender: AnyObject) {
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    ///
    /// Allow editing of the table.
    ///
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell!.textLabel!.text = expenses[indexPath.row].description
        
        return cell!
    }

}

