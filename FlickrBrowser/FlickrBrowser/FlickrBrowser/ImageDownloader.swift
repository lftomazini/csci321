//
//  ImageDownloader.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 3/7/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

///
/// Download an image from the web. Display the network activity indicator
/// while the transfer is taking place.
///
class ImageDownloader: NSOperation {
    /// URL of the image to be downloaded
    let imageURL: NSURL
    
    /// Image downloaded
    var image: UIImage?
    
    /// ID of the image
    var imageID: String
    
    init (imageURL: NSURL, imageID: String) {
        self.imageURL = imageURL
        self.imageID = imageID
    }
    
    ///
    /// Downloads animage from the web
    ///
    override func main() {
        autoreleasepool {
            if self.cancelled {
                return
            }
            var imageData: NSPurgeableData?
            imageData = CacheManager.sharedInstance.getCache(self.imageID)
            if imageData == nil {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                imageData = NSPurgeableData(contentsOfURL: self.imageURL)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if imageData != nil {
                    CacheManager.sharedInstance.setCache(imageData!, forKey: self.imageID)
                }
            }
            if self.cancelled || imageData == nil {
                return
            }
            self.image = UIImage(data: imageData!)
        }
    }
}