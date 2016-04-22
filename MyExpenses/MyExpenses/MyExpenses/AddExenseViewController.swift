//
//  AddExenseViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/7/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class AddExpenseViewController: ViewController {
    @IBOutlet weak var itemTitleField: UITextField!
    @IBOutlet weak var valueTitleField: UITextField!
    @IBOutlet weak var dayBoughtDatePicker: UIDatePicker!
    
    var entries = [Expenses]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
        print("cancel")
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
        print("done")
        let newExpense = Expenses(category: Expenses.Categories.Books, date: dayBoughtDatePicker.date as NSDate,value: NSString(string: valueTitleField.text!).floatValue as Float,item: itemTitleField.text! as String)
        entries.append(newExpense)
        //        let textField = alert.textFields!.first
//        self.names.append(textField!.text!)
//        self.tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
