//
//  LibraryImageViewController.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 2/26/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class LibraryImageViewController: ViewController, UIScrollViewDelegate {

    /// This is the UIImageview in which the image will be displayed. We will
    /// insert thisview into a scroll view.
    var imgView: UIImageView?
    
    /// This is the image to be displayed.
    var image: UIImage?
    
    /// Should we adjust the zoom scale so that the entire image fits on the
    /// screen? Once the user has pinched, we stop the automatic adjustment.
    /// Otherwise, the automatic adjusting continues, even when the user
    /// rotates the device.
    var userHasZoomed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let libraryImageUrl = "http://eg.bucknell.edu/~iBucknell/facebookFullAlbums/Cover%20Photos/10151051623442340.jpg"
        imageURL = NSURL(string: libraryImageUrl)
        scrollView.delegate = self
        addImageView()
    }
    
    ///
    /// Creates an image view and adds it to the scroll view. If, for some
    /// reason the iage property hasn't been set (shouldn't happen), don't do
    /// anything.
    ///
    func addImageView() {
        if let theImage = image {
            imgView = UIImageView(image:  theImage)
            imgView?.translatesAutoresizingMaskIntoConstraints = false
            imgView!.image = theImage
            scrollView.contentSize = theImage.size
            scrollView.zoomScale = 1.0
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
            scrollView.addSubview(imgView!)
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

// MARK: - UIScrollViewDelegate

extension LibraryImageViewController {
    
    ///
    /// Lets the scroll view know that we want to scroll the image
    ///
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    ///
    /// Records when the user has zoomed so we can stop automatically adjusting
    /// the scale factor.
    ///
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        userHasZoomed = true
    }
}