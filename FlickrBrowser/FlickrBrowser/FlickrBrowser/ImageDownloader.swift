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
    
    /// The unique ID of the picture
    var imageID: String
    
    let flickrDownloader = FlickrDownloader()
    
    init (imageURL: NSURL) {
        self.imageURL = imageURL
        self.imageID = flickrDownloader.getPhotoID(imageURL)
    }
    
    ///
    /// Downloads animage from the web
    ///
    override func main() {
        autoreleasepool {
            if self.cancelled {
                return
            }
            
            
            if getCacheForKey(imageID) != nil {
                
            } else {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                let imageData = NSData(contentsOfURL: self.imageURL)
                setCache(, photoID)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if self.cancelled || imageData == nil {
                    return
                }
                self.image = UIImage(data: imageData!)
            }
        }
    }
}
