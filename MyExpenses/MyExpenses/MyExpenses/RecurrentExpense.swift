//
//  RecurrentExpense.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/25/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit


///
/// Class of type RecurrentExpense that extends the Enxpenses class
///
class RecurrentExpense: Expenses {
    /// End date of the recurrent expense
    var dateEnd: NSDate!
    
    ///
    /// Initializes an Recurrent Expenses instance.
    /// - parameter category: the name of the category of the item according to super class
    /// - parameter date: the initial date when the item is commonly bought
    /// - parameter dateEnd: the end date when the item is commonly bought
    /// - parameter value: the value of the item bought
    /// - parameter item: the name description of the item
    ///
    init(category: Categories, date: NSDate, dateEnd:NSDate, value: Float, item: String) {
        super.init(category: category, date: date, value: value, item: item)
        self.dateEnd = dateEnd
    }
}
