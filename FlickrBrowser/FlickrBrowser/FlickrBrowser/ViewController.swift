//
//  ViewController.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 2/26/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    /// Should we adjust the zoom scale so that the entire image fits on the
    /// screen? Once the user has pinched, we stop the automatic adjustment.
    /// Otherwise, the automatic adjusting continues, even when the user
    /// rotates the device.
    var userHasZoomed = false
    
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
        scrollView.delegate = self
        addImageView()
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
    
    ///
    /// Creates an image view and adds it to the scroll view. If, for some
    /// reason the iage property hasn't been set (shouldn't happen), don't do
    /// anything.
    ///
    func addImageView() {
        if let theImage = image {
            scrollView.contentSize = theImage.size
            scrollView.zoomScale = 1.0
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
        } else {
            print("\(__FUNCTION__): image isn't set!")
        }
    }
    
    ///
    /// Sets the zoom scale so that all of the picture is visible
    ///
    override func viewDidLayoutSubviews() {
        if !userHasZoomed {
            scrollView.zoomScale = 1.0
            scrollView.setContentOffset(CGPointZero, animated: false)
            let widthZoomScale = scrollView.bounds.size.width / scrollView.contentSize.width
            let heightZoomScale = scrollView.bounds.size.height / scrollView.contentSize.height
            let desiredZoomScale = fmin(widthZoomScale, heightZoomScale)
            scrollView.setZoomScale(desiredZoomScale, animated: false)
        }
    }
    
}



