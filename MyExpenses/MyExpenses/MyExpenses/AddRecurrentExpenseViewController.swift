//
//  AddRecurrentExenseViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/7/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

///
/// View controller to manage the creation of new recurrent expenses
///
class AddRecurrentExpenseViewController: GraphViewController {
    @IBOutlet weak var itemTitleField: UITextField!
    @IBOutlet weak var valueTitleField: UITextField!
    @IBOutlet weak var initialTimeDatePicker: UIDatePicker!
    @IBOutlet weak var finalTimeDatePicker: UIDatePicker!
    
    var recurrentExpense: RecurrentExpense!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///
    /// Creates an Expense instance with the title and band when the segue is the
    /// result of tapping on the Done button.
    ///
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addRecurrentExpenseNavigation" {
            recurrentExpense = RecurrentExpense(category: Expenses.Categories.Drinks, date: initialTimeDatePicker.date, dateEnd: finalTimeDatePicker.date,value: (valueTitleField.text! as NSString).floatValue, item: itemTitleField.text!)
        }
    }
}