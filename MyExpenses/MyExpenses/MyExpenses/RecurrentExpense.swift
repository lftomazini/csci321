//
//  RecurrentExpense.swift
//  MyExpenses
//
//  Created by Luís Felipe on 4/25/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class RecurrentExpense: Expenses {
    var dateEnd: NSDate!
    
    init(category: Categories, date: NSDate, dateEnd:NSDate, value: Float, item: String) {
        super.init(category: category, date: date, value: value, item: item)
        self.dateEnd = dateEnd
    }
    
}

//init(category: Categories, date: NSDate, value: Float, item: String) {
//    self.category = category
//    self.date = date
//    self.value = value
//    self.item = item
//}
