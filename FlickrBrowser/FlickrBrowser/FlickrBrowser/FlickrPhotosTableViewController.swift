//
//  FlickrPhotosTableViewController.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 2/29/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class FlickrPhotosTableViewController: UITableViewController {

    /// Each array entry is a dictionary that describes a Flickr photo.
    var photos: [[String: AnyObject]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newPhotos = FlickrDownloader.bucknellPhotos() {
            photos = newPhotos
            title = "Bucknell Photos"
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    ///
    /// Determines the title for a cell. The title is just the photo title.
    ///
    /// - parameter row: the table row that needs a title
    ///
    /// - returns: the photo's title
    ///
    func titleForRow(row: Int) -> String {
        if let title = FlickrDownloader.getPhotoTitle(photos[row]) {
            return title
        } else {
            return "Untitled"
        }
    }
    
    ///
    /// Determines the subtitle for a cell. The subtitle is just the photo's owner,
    /// which is most likely the photographer.
    ///
    /// - parameter row: the table row that needs an owner
    ///
    /// - returns: the photo's owner
    ///
    func subtitleForRow(row: Int) -> String {
        if let ownerName = FlickrDownloader.getPhotoOwnerName(photos[row]) {
            return ownerName
        } else {
            return "Untitled"
        }
    }
    
    ///
    /// Gets a table cell and initializes it with a title and subtitle.
    ///
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Flickr Photo", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = titleForRow(indexPath.row)
        cell.detailTextLabel!.text = subtitleForRow(indexPath.row)
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier ==  "Flickr Photo" {
//            let flickrPhotosTableViewController = segue.destinationViewController as! FlickrPhotosTableViewController
//            let filePath = FlickrDownloader.bucknellPhotos()
//            let image: UIImage? = UIImage(named: filePath)
//            if image == nil {
//                print("Image is nil")
//            } else {
//                flickrPhotosTableViewController.title = (selectedThumbnailFileName() as NSString).stringByDeletingPathExtension
//                flickrPhotosTableViewController.image = image
//            }
//        }
    }
}
