//
//  Expenses.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/28/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit


///
/// Class of type Expenses that has the attributes of a new Expenses object
///
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
    
    /// Category of an expense
    let category: Categories
    
    /// Date in which an expense was bought
    let date: NSDate
    
    /// Price paid for an expense
    let value: Float
    
    /// Inofrmation of the expense
    let item: String
    
    var description: String {
        return "\(item) - \(category): $\(value) bought on \(date)"
    }
    
    ///
    /// Initializes an Expenses instance.
    /// - parameter category: the name of the category of the item
    /// - parameter date: the date when the item was bought
    /// - parameter value: the value of the item bought
    /// - parameter item: the name description of the item
    ///
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