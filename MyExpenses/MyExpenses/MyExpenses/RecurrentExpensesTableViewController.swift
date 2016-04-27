//
//  RecurrentExpensesTableViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/11/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class RecurrentExpensesTableViewController: UITableViewController {

    /// Each array entry is a dictionary that describes a expense
    var recurrentExpenses: [[String: RecurrentExpense]] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
//        return title = recurrentExpenses[row].item + " - $" + recurrentExpenses[row].value
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Recurrent Expense", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = titleForRow(indexPath.row)
        cell.detailTextLabel!.text = subtitleForRow(indexPath.row)

        // Configure the cell...

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
