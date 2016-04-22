//
//  ViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/19/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    //Insert below the tableView IBOutlet
    var expenses = [Expenses]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "\"The List\""
        tableView?.registerClass(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
        let shortcut = UIApplicationShortcutItem(type: "addItem", localizedTitle: "Add Item", localizedSubtitle: "Dynamic Action", icon: UIApplicationShortcutIcon(type: .Add), userInfo: nil)
        UIApplication.sharedApplication().shortcutItems = [shortcut]
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNew(sender: AnyObject) {
        print("adding new")
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell!.textLabel!.text = expenses[indexPath.row].description
        
        return cell!
    }

}

