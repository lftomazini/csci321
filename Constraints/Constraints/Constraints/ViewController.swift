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
        let leftView = addLeftView(alignedWidth: headlineView)
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
        
        ///
        /// Adds a light purple view on the left. Its width will be 0.3 of the
        /// headline view, and its height will be variable, always extending to 20 
        /// points of the bottom of the screen.
        ///
        /// - parameter headlineView: the view across the top of the screen.
        ///
        /// - returns: the left view
        ///
        func addLeftView(alignedWidth headlineView: UIView) -> UIView {
            let leftView = UIView()
            leftView.backgroundColor = UIColor(red: 0.725, green: 0.739, blue: 1.0, alpha: 1.0)
            view.addSubview(leftView)
            leftView.translatesAutoresizingMaskIntoConstraints = false
            
            // The left view has width of  30% of the headline view width.
            let leftViewWidth = NSLayoutConstraint(item: leftView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.3, constant: 200)
            leftView.addConstraint(leftViewWidth)
            
            // The left view is always 20 point from the bottom.
            let leftViewHeight = NSLayoutConstraint(item: leftView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -20.0)
            view.addConstraint(leftViewHeight)
            
            // The left view has its top aligned with the bottom of the headline View
            // with 20 points between them
            let leftViewTop = NSLayoutConstraint(item: leftView, attribute: .Top, relatedBy: .Equal, toItem: headlineView, attribute: .Bottom, multiplier: 1.0, constant: 20.0)
            view.addConstraint(leftViewTop)
            
            // On the left, the left view should be 20 points from the edge of the screen
            let leftViewLeft = NSLayoutConstraint(item: leftView, attribute: .Left, relatedBy: .Equal, toItem: headlineView, attribute: .Left, multiplier: 1.0, constant: 0.0)
            view.addConstraint(leftViewLeft)
            
            return leftView
        }

    }

