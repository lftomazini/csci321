//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Luís Felipe on 2/1/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import Foundation

/// This is the model for the tip calculator
public class TipCalculatorModel {
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
    
    ///
    /// Calculates possible tip amounts based on the bill before tax
    ///
    /// - returns: A dictionary with each entry having a key that is the tip
    /// percentage and the value is the tip amount.
    ///
    public func possibleTips() -> [Int : Double] {
        let tipPercents = [10, 15, 18, 20]
        var result = [Int : Double]()
        for tipPercent in tipPercents {
            result [tipPercent] = calculateTip(usingPercent: tipPercent)
        }
        return result
    }
}