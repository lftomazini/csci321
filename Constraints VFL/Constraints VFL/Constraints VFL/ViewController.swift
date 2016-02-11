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
    var centerredView: UIView?
    var leftViewExpanded: Bool = false
    var tapMeButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        addHeadlineView()
        addLeftView()
        addVerticalConstraints()
        addCenterredView()
        addHeightConstraints()
        //addButton()
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
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(topPadding)-[headlineView(headlineViewHeight)]-20-[leftView]-20-|", options: .AlignAllLeft, metrics: metrics, views: ["headlineView" : headlineView!, "leftView" : leftView!]))
    }
    
    ///
    ///
    ///
    ///
    func addCenterredView(){
        centerredView = UIView()
        centerredView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        centerredView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerredView!)

        //let metrics = ["leftWiewWidth" : ]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[leftView]-0-[centerredView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["leftView" : leftView!, "centerredView" : centerredView!]))
    }
    
    ///
    ///
    ///
    ///
    func addHeightConstraints() {
        let metrics = ["headlineViewHeight" : 100]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[headlineView(headlineViewHeight)]-20-[centerredView]-20-|", options: .AlignAllTrailing, metrics: metrics, views: ["headlineView" : headlineView!, "centerredView" : centerredView!]))
    }
    
    ///
    ///
    ///
    ///
    func addButton(){
        tapMeButton = UIButton()
        tapMeButton!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tapMeButton!)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[centerredView", options: .AlignAllCenterX, metrics: nil, views: ["centerredView" : centerredView!]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[centerredView", options: .AlignAllCenterY, metrics: nil, views: ["centerredView" : centerredView!]))
        tapMeButton!.addTarget(self, action: "buttonTapped", forControlEvents: .TouchUpInside)
    }
    
    ///
    ///
    ///
    ///
    func buttonTapped() {
        let multiplier: CGFloat = leftViewExpanded ? 0.3 : 0.7
        leftViewExpanded = !leftViewExpanded
        view.removeConstraint(leftWidthConstraint!)
        leftWidthConstraint = leftWidthConstraintMultiplier(multiplier)
        view.addConstraint(leftWidthConstraint!)
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4.0, options: .LayoutSubviews, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
}