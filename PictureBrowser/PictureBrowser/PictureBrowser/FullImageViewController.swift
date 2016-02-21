//
//  FullImageViewController.swift
//  PictureBrowser
//
//  Created by Luís Felipe on 2/19/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    /// This is the image to be displayed.
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
