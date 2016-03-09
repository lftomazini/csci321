//
//  ImageViewController.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 2/26/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

///
/// Sets and changes the image on the view.
///
class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    /// The activity indicator that's displayed while an image is loading.
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    /// This is an NSOperation subclass for downloading images in the background.
    var downloader: ImageDownloader?
    
    @IBOutlet weak var scrollView: UIScrollView!
    let imageView = UIImageView(frame: CGRectZero)
    var image: UIImage?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        resetImage()
        navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
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
        downloader = ImageDownloader(imageURL: imageURL!)
        downloader!.qualityOfService = .UserInitiated
        downloader!.completionBlock = {
            if self.downloader!.cancelled || self.downloader!.image == nil {
                return
            }
            NSThread.sleepForTimeInterval(4.0)
            dispatch_async(dispatch_get_main_queue(), {
                self.scrollView.zoomScale = 1.0
                self.scrollView.contentSize = self.downloader!.image!.size
                self.scrollView.minimumZoomScale = 0.1
                self.scrollView.maximumZoomScale = 5.0
                self.imageView.image = self.downloader!.image!
                self.imageView.translatesAutoresizingMaskIntoConstraints = false
                self.imageView.frame = CGRectMake(0.0, 0.0, self.downloader!.image!.size.width, self.downloader!.image!.size.height)
                self.spinner.stopAnimating()
            })
        }
        spinner.startAnimating()
        NSOperationQueue().addOperation(downloader!)
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
    
    /// 
    /// Cancel if a download is occuring
    ///
    override func viewWillDisappear(animated: Bool) {
        if self.downloader!.executing || self.downloader!.ready {
            self.downloader!.cancel()
            print(self.downloader!.cancelled)
        }
        super.viewWillDisappear(true)
    }
}

// MARK: - UIScrollViewDelegate

extension ImageViewController {
    
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


