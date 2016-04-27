//
//  Expenses.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/28/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class Expenses: CustomStringConvertible, Comparable {
    
    /// Available categories for expenses
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
    
    let category: Categories
    let date: NSDate
    let value: Float
    let item: String
    
    var description: String {
        return "\(item) - \(category): $\(value) bought on \(date)"
    }
    
    init(category: Categories, date: NSDate, value: Float, item: String) {
        self.category = category
        self.date = date
        self.value = value
        self.item = item
    }
}

///
/// Overloads the less than operator so we can compare expenses.
/// - parameter left: left operand
/// - parameter right: right operand
/// - returns: true if left < right, false otherwise
///
    func <(left: Expenses, right: Expenses) -> Bool {
//    if left.band == right.band {
//    return left.title < right.title
//    }
//    return left.band < right.band
        return true
    }

///
/// Overloads the equality operator so we can compare expenses.
/// - parameter left: left operand
/// - parameter right: right operand
/// - returns: true if left == right, false otherwise.

    func ==(left: Expenses, right: Expenses) -> Bool {
    return left.date == right.date && left.value == right.value && left.item == right.item && left.category == right.category
}