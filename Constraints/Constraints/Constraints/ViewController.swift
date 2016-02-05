//
//  ViewController.swift
//  Constraints
//
//  Created by Luís Felipe on 2/5/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let headlineView = addHeadlineView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    ///
    /// Add subviews and their constraints to the main view.
    ///
    extension ViewController {
        
        ///
        /// Adds the headline view. This view is always as wide as the screen width
        /// a 20 point margin on either side It is always 60 points from the top
        /// and it is 100 pixels high.
        ///
        /// - returns: the headline view that was just added
        ///
        func addHeadlineView() -> UIView {
            let headlineView = UIView()
            headlineView.backgroundColor = UIColor(red: 0.423, green: 0.343, blue: 0.804, alpha: 1.0)
            view.addSubview(headlineView)
            headlineView.translatesAutoresizingMaskIntoConstraints = false
            
            // The headline view always has height 100.0.
            let headlineHeight = NSLayoutConstraint(item: headlineView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0)
            headlineView.addConstraint(headlineHeight)
            
            // Add a constraint that says the headline view is 60 points from the top
            // of the screen.
            let headlineTop = NSLayoutConstraint(item: headlineView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 60.0)
            view.addConstraint(headlineTop)
            
            // On the left, the headline view should be 20 points from the edge of
            // the screen.
            let headlineLeft = NSLayoutConstraint(item: headlineView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 20.0)
            view.addConstraint(headlineLeft)

            // The headline view should be 20 points from the right edge of the
            // screen.
            let headlineRight = NSLayoutConstraint(item: headlineView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -20.0)
            view.addConstraint(headlineRight)
            
            return headlineView
        }
    }

