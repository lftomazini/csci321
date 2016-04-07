//
//  ViewController.swift
//  MyExpenses
//
//  Created by Luís Felipe on 3/19/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func cancel(segue: UIStoryboardSegue) {
        
    }
 
    @IBAction func done(segue: UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

