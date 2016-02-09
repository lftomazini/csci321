//
//  ViewController.swift
//  Constraints VFL
//
//  Created by Luís Felipe on 2/8/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var headlineView: UIView?
    var leftView: UIView?
    var leftWidthConstraint: NSLayoutConstraint?
    var tapMeButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        addHeadlineView()
        addLeftView()
        addVerticalConstraints()
        addButton()
        addHeightConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

///
/// Add views to the ViewController
///
extension ViewController {
    ///
    /// Adds the headline view. This view is always as wide as the screen with
    /// a 20 point margin on either sides.
    ///
    func addHeadlineView(){
        headlineView = UIView()
        headlineView!.backgroundColor = UIColor(red: 0.423, green: 0.343, blue: 0.804, alpha: 1.0)
        headlineView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headlineView!)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[headlineView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["headlineView" : headlineView!]))
    }
    
    ///
    ///
    ///
    ///
    func addLeftView() {
        leftView = UIView()
        leftView!.backgroundColor = UIColor(red: 0.725, green: 0.739, blue: 1.0, alpha: 1.0)
        leftView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftView!)
        leftWidthConstraint = leftWidthConstraintMultiplier(0.3)
        view.addConstraint(leftWidthConstraint!)
    }
    
    ///
    ///
    ///
    ///
    func leftWidthConstraintMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: leftView!, attribute: .Width, relatedBy: .Equal, toItem: headlineView!, attribute: .Width, multiplier: multiplier, constant: 0.0)
    }
    
    ///
    ///
    ///
    ///
    func addVerticalConstraints() {
        let metrics = ["topPadding" : 60, "headlineViewHeight" : 100]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(topPadding)-[headlineView(headlineViewHeight)]-[leftView]-20-|", options: .AlignAllLeft, metrics: metrics, views: ["headlineView" : headlineView!, "leftView" : leftView!]))
    }
    
    ///
    ///
    ///
    ///
    func addButton(){
        tapMeButton = UIButton()
        tapMeButton!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        tapMeButton!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tapMeButton!)

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[leftView]-[tapMeButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["leftView" : leftView!, "tapMeButton" : tapMeButton!]))
    }
    
    ///
    ///
    ///
    ///
    func addHeightConstraints() {
        let metrics = ["headlineViewHeight" : 100]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V: |-20-[headlineView(headlineViewHeight)]-20-[tapMeButton]-20-|", options: .AlignAllRight, metrics: metrics, views: ["headlineView" : headlineView!, "tapMeButton" : tapMeButton!]))
    }
}