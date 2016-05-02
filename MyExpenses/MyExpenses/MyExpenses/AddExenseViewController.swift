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
    
    var expense: Expenses!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///
    /// Creates an Expense instance with the title and band when the segue is the
    /// result of tapping on the Done button.
    ///
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddExpense" {
            expense = Expenses(category: Expenses.Categories.Drinks, date: dayBoughtDatePicker.date, value: (valueTitleField.text! as NSString).floatValue, item: itemTitleField.text!)
        }
    }

}
