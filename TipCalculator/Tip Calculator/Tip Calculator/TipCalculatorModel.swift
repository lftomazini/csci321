//
//  TipCalculatorModel.swift
//  Tip Calculator
//
//  Created by Luís Felipe on 2/1/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import Foundation


/// This is the model for the tip calulator.
public class TiPCalculatorModel {
    /// The tip is calculated on the bill total before tax
    var totalBeforeTax: Double
    
    ///
    /// Initializes the total before tax.
    ///
    /// - parameter totalBeforeTax: is the bill total before tax
    ///
    public init(totalBeforeTax: Double) {
        self.totalBeforeTax = totalBeforeTax
    }
    
    ///
    /// Calculates the tip using the given percentage.
    ///
    /// - parameter tipPercent: is the tip amount as a percentage
    ///
    public func calculateTip(usingPercent tipPercent: Int) -> Double {
        return totalBeforeTax * Double(tipPercent) / 100.00
    }
}