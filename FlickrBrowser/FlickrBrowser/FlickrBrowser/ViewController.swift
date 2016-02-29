//
//  ViewController.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 2/26/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// This is the URL of the image we will display.
    var imageURL: NSURL? {
        didSet {
            resetImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    let imageView = UIImageView(frame: CGRectZero)
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        resetImage()
    }

    ///
    /// Retrieves the image pointed to by imageURL and inserts it into the 
    /// scroll view.
    ///
    func resetImage() {
        if scrollView == nil {
            return
        }
        scrollView.contentSize = CGSizeZero
        imageView.image = nil
        if imageURL == nil {
            return
        }
        let imageData = NSData(contentsOfURL: imageURL!)
        if imageData == nil {
            return
        }
        image = UIImage(data: imageData!)
        if image == nil {
            return
        }
        scrollView.contentSize = image!.size
        scrollView.zoomScale = 1.0
        imageView.image = image!
        imageView.frame = CGRectMake(0.0, 0.0, image!.size.width, image!.size.height)
    }
}

