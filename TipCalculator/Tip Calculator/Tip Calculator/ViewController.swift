//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Luís Felipe on 1/29/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// This is where the user enters the bill total (without tax)
    @IBOutlet weak var textField: UITextField!
    
    /// Model object
    let model = TiPCalculatorModel(totalBeforeTax: 33.25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.keyboardType = .NumberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///
    /// Responds to a tap on the Calculate button by calculating the tip
    ///
    @IBAction func respondToCalculateTap() {
        print("Working")
    }
    
    /// The calculation results are displayed here
    @IBOutlet weak var resultTextField: UITextView!
    
    ///
    /// Responds to a tap on the Calculate button by calculating the tip
    ///
    /// - parameter sender: a tap gesture recognizer
    ///
    @IBAction func respontToViewTap(sender: UITapGestureRecognizer) {
    }
}

