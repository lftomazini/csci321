//
//  RecurrentExpensesTableViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/11/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

///
/// Manages the Recurrent expenses added
///
class RecurrentExpensesTableViewController: UITableViewController {

    /// Each array entry is a dictionary that describes a expense
    var recurrentExpenses: [[String: RecurrentExpense]] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///
    /// There's a table row for each recurrent expense
    ///
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recurrentExpenses.count
    }
    
    ///
    /// Determines the title for a cell. The title is just the item name and its value.
    ///
    /// - parameter row: the table row that needs a title
    ///
    /// - returns: the recurrent expense's title
    ///
    func titleForRow(row: Int) -> String {
        return "title"
    }
    
    ///
    /// Determines the title for a cell. The title is just the item name and its value.
    ///
    /// - parameter row: the table row that needs a title
    ///
    /// - returns: the recurrent expense's title
    ///
    func subtitleForRow(row: Int) -> String {
        return "subtitle"
    }

    ///
    /// Manages a cell instance of the table view
    ///
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Recurrent Expense", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = titleForRow(indexPath.row)
        cell.detailTextLabel!.text = subtitleForRow(indexPath.row)

        return cell
    }
}
