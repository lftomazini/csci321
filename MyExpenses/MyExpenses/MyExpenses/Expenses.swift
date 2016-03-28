//
//  Expenses.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/28/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class Expenses {
    
    /// Available categories sizes
    enum Categories {
        case Books
        case Drinks
        case Entertainment
        case Food
        case General
        case Gifts
        case Grocery
        case Housing
        case Medical
        case Mobile
        case Personal
        case Shopping
        case Transport
        case Travel
    }
    
    var category: Categories
    var date: NSDate
    var value: Float
    var description: String
    
    init() {
        self.category = Categories.General
        self.date = NSDate()
        self.value = 0.0
        self.description = ""
    }
}