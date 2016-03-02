//
//  FickrDownloader.swift
//
//  Created by Rick Zaccone on 2014-11-16.
//  Copyright (c) 2014 Rick Zaccone. All rights reserved.
//
//  This class retrieves photos from Flickr.  The primary entry points are the
//  following class methods:
//
//  latestFlickrPhotos() returns an array of the latest photos on Flickr.  The
//                       results returned change about every 15 minutes.
//
//  bucknellPhotos() returns an array of Bucknell photos.  The titles are OK,
//                   owner is always Bucknell University.  The tags are
//                   terrible!
//
// urlForPhoto(_:format:) gets the URL for a photo
//
// These metods return information about a photo:
//
// getPhotoID(_:), getPhotoDescription(_:), getPhotoTitle(_:),
// getPhotoOwnerName(_:), getPhotoTags(_:)
//
// 2015-11-02 Changes so that it is compatible with Swift 2.1

import Foundation

/// Nothing works without a Flickr API key!  You need to provide your key here.
let flickrAPIKey = "9c85b5cf9ed3936f46790b05befa9d81"

/// Available photo sizes
enum FlickrPhotoFormat {
    case Square    // 75x75
    case Large     // 1024x768
    case Original  // at least 1024x768
}

/// The base URL of the Flickr requests
let requestBase = "https://api.flickr.com/services/rest/?"

/// Should we log information about our Flickr requests?
let flickrLog = false

///
/// Use this class to download photos from Flickr
///
class FlickrDownloader {

    ///
    /// Asks Flickr to send some information.
    ///
    /// - parameter query: a strng containing the Flickr request
    ///
    /// - returns: A dictionary containing the Flickr response
    ///
    class func performFlickrQuery(query: String) -> [String: AnyObject]? {
        let formattedQuery = String(format: "%@&format=json&nojsoncallback=1&api_key=%@", query, flickrAPIKey);
        let escapedQuery: String! = formattedQuery.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        if escapedQuery == nil {
            print("FlickrDownloader: Unable to escape request string.")
            return nil
        }
        if flickrLog {
            print("FlickrDownloader query: \(escapedQuery)")
        }
        let url: NSURL! = NSURL(string: escapedQuery)
        if url == nil {
            print("FlickrDownloader: Unable to create URL.")
            return nil
        }
        var jsonString: String!
        do {
            jsonString = try String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print("FlickrDownloader: Unable to open url.  Error: \(error.localizedDescription)")
            return nil
        }
        let jsonData: NSData! = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if jsonData == nil {
            print("FlickrDownloader: Unable to encode json data.")
            return nil
        }
        var results: [String: AnyObject]!
        do {
            results = try NSJSONSerialization.JSONObjectWithData(jsonData,
            options:  [NSJSONReadingOptions.MutableContainers, NSJSONReadingOptions.MutableLeaves]) as! [String : AnyObject]
        } catch let error as NSError {
            print("FlickrDownloader: Could not parse json data.  Error: \(error.localizedDescription)")
            return nil
        }
        if flickrLog {
            print("FlickrDownloader received: \(results)")
        }
        return results
    }

    ///
    /// Determines the URL for a Flickr photo.
    ///
    /// - parameter photo: is a dictionary that describes a photo.  This is the
    ///                    dictionary returned by Flickr.
    ///
    /// - parameter format: is the photo format desired.
    ///
    /// - returns: a string containing the URL.
    ///
    class func urlStringForPhoto(photo: [String: AnyObject], format: FlickrPhotoFormat) -> String? {
        let farm: Int! = photo["farm"]! as? Int
        let server: String! = photo["server"]! as? String
        let photoID: String! = photo["id"]! as? String
        var secret: String! = photo["secret"]! as? String
        var fileType = "jpg"
        if format == .Original {
            secret = photo["originalsecret"]! as! String
            fileType = photo["originalformat"]! as! String
        }
        if farm == nil || server == nil || photoID == nil || secret == nil {
            return nil
        }
        var formatString: String
        switch (format) {
        case .Square:
            formatString = "s"
        case .Large:
            formatString = "b"
        case .Original:
            formatString = "o"
        }
        let urlString = String(format: "https://farm%d.static.flickr.com/%@/%@_%@_%@.%@",
            farm, server, photoID, secret, formatString, fileType)
        return urlString
    }

    ///
    /// Determines the URL for a photo.
    ///
    /// - parameter photo: is a dictionary that describes a photo
    ///
    /// - parameter format: is the desired photo size
    ///
    /// - returns: the URL of the photo
    ///
    class func urlForPhoto(photo: [String: AnyObject], format: FlickrPhotoFormat) -> NSURL? {
        let urlString: String! = urlStringForPhoto(photo, format: format)
        if urlString == nil {
            return nil
        }
        return NSURL(string: urlString)
    }

    ///
    /// Retrieves an array of Bucknell photos.  The Flickr request returns a
    /// dictionary with keys "stat" and "photoset".    "stat" is just the status
    /// of the request.  "photoset" is another dictionary with the following
    /// keys: owner, primary, per_page, id, perpage, pages, title, photo,
    /// page, total, ownername.  "photo" is an array of dictionaries describing
    /// the Bucknell photos.
    ///
    /// - returns: An array of Bucknell photos
    ///
    class func bucknellPhotos() -> [[String: AnyObject]]? {
        let request = requestBase +
            "method=flickr.photosets.getPhotos" +
            "&photoset_id=72157629230953073" +
        "&extras=original_format,tags,description,geo,date_upload,owner_name,place_url"
        let fetchResults: [String: AnyObject]! = performFlickrQuery(request)
        if fetchResults == nil {
            return nil
        }
        let photoSet: [String: AnyObject]! = fetchResults["photoset"]! as? [String: AnyObject]
        if photoSet == nil {
            print("FlickrDownloader: photoset is not present")
            return nil
        }

        let photos: [[String: AnyObject]]! = photoSet["photo"]! as? [[String: AnyObject]]
        if photos == nil {
            print("FlickrDownloader: No photos returned")
            return nil
        }
        return photos
    }

    ///
    /// Retrieves a list of recent Flickr photos.  The Flickr request returns a
    /// dictionary with keys "stat" and "photos".  "stat" is just the status of
    /// the request.  "photos" is another dictionary with the following keys
    /// and values.
    ///
    /// - key: "perpage" value: Int
    /// - key: "pages"   value: Int
    /// - key: "photo"   value: Array
    /// - key: "total"   value: String
    /// - key: "page"    value: Int
    ///
    /// "photo" is an array of dictionaries that describes the photos.
    ///
    /// - returns: An array of recent photos.
    ///
    class func latestFlickrPhotos() -> [[String: AnyObject]]? {
        let request = requestBase + "method=flickr.photos.search"
            + "&per_page=500" + "&license=1,2,4,7" + "&has_geo=1"
            + "&extras=original_format,tags,description,geo,date_upload,owner_name,place_url"
        let fetchResults: [String: AnyObject]! = performFlickrQuery(request)
        if fetchResults == nil {
            return nil
        }
        let photos: [String: AnyObject]! = fetchResults["photos"]! as? [String: AnyObject]

        if photos == nil {
            print("FlickrDownloader: No photos present")
            return nil
        }
        return photos["photo"]! as? [[String: AnyObject]]
    }

    ///
    /// Retrieves a photo's ID.
    ///
    /// - parameter photo: a dictionary describing the photo
    ///
    /// - returns: the photo ID
    ///
    class func getPhotoID(photo: [String: AnyObject]) -> String? {
        return photo["id"]! as? String
    }

    ///
    /// Retrieves a photo's description
    ///
    /// - parameter photo: a dictionary describing the photo
    ///
    /// - returns: the photo description
    ///
    class func getPhotoDescription(photo: [String: AnyObject]) -> String? {
        if let description = photo["description"]! as? [String: AnyObject] {
            return description["_content"]! as? String
        }
        return nil
    }

    ///
    /// Retrieves a photo's title
    ///
    /// - parameter photo: a dictionary describing the photo
    ///
    /// - returns: the photo title
    ///
    class func getPhotoTitle(photo: [String: AnyObject]) -> String? {
        return photo["title"]! as? String
    }

    ///
    /// Retrieves a photo's owner name
    ///
    /// - parameter photo: a dictionary describing the photo
    ///
    /// - returns: the photo owner name
    ///
    class func getPhotoOwnerName(photo: [String: AnyObject]) -> String? {
        return photo["ownername"]! as? String
    }

    ///
    /// Retrieves a photo's tags
    ///
    /// - parameter photo: a dictionary describing the photo
    ///
    /// - returns: the photo tags
    ///
    class func getPhotoTags(photo: [String: AnyObject]) -> String? {
        return photo["tags"]! as? String
    }
}
