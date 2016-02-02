//
//  ViewController.swift
//  TipCalculator
//
//  Created by Luís Felipe on 2/1/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    ///This is where the user enters the bill total.
    @IBOutlet weak var totalBeforeTax: UITextField!

    /// The calculation results are displayed here.
    @IBOutlet weak var resultTextView: UITextView!
    
    /// Model object
    let model = TipCalculatorModel(totalBeforeTax: 33.25)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ///
    /// Responds to a tap on the Calculate button by calculating the tip.
    ///
    @IBAction func respondToCalculateTap() {
        model.totalBeforeTax = (totalBeforeTax.text! as NSString).doubleValue
        let possibleTips = model.possibleTips()
        var result = ""
        for (tipPercent, tipAmount) in possibleTips {
            let tipAmountRounded = Double(round(100*tipAmount)/100)
            result += "\(tipPercent)%: $ \(tipAmountRounded)\n"
        }
        resultTextView.text = result
    }
    
    ///
    /// Provides initial values o the UI using the values that's currently in
    /// the model for the toal before tax. There are no results yet.
    ///
    func initializeUI () {
        totalBeforeTax.text = String(format: "%.2f", model.totalBeforeTax)
        resultTextView.text = ""
    }
    
    ///
    /// Responds to a tap on the main view by dismissing the keyboard.
    ///
    /// - parameter sender: a tap gesture recognizer.
    ///
    @IBAction func respondToViewTap(sender: UITapGestureRecognizer) {
    }
}

