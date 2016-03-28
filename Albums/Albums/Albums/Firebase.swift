//
//  Firebase.swift
//  Albums
//
//  Created by Rick Zaccone
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import Foundation

typealias FirebaseSaveCompletion = (NSError?) -> Void
typealias FirebaseFetchCompletion = ([Album]?, NSError?) -> Void
typealias FirebaseDeleteCompletion = (NSError?) -> Void

/*
 
 Make this change to Info.plist or nothing works!
 
 This technical note explains that there are certain ciphers that App Transport
 Security accepts by default.
 
 https://developer.apple.com/library/prerelease/mac/technotes/App-Transport-Security-Technote/index.html
 
 Setting NSExceptionRequiresForwardSecrecy to NO adds additional ciphers which
 makes Firebase happy.  Add the following to Info.plist to make the operations
 defined in this class work.
 
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSExceptionDomains</key>
 <dict>
 <key>firebaseio.com</key>
 <dict>
 <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
 <false/>
 <key>NSIncludesSubdomains</key>
 <true/>
 </dict>
 </dict>
 </dict>
 
 */

///
/// The Firebase class handles retrieving, saving and deleting albums from
/// Firebase.
///
class Firebase {
    /// The URL componets of the albums on Firebase
    let urlComponents: NSURLComponents!
    
    /// The URL of the albums on Firebase
    var albumsURL: NSURL {
        return urlComponents.URL!
    }
    
    ///
    /// Intializes a Firebase instance with the URL of the project.
    /// - parameter hostName: the name of the project on Firebase
    ///
    init(hostName: String) {
        urlComponents = NSURLComponents()
        urlComponents.host = hostName
        urlComponents.path = "/albums.json"
        urlComponents.scheme = "https"
    }
    
    ///
    /// Retrieves a list of albums from Firebase.
    /// - parameter completionHandler: gets called when the operation finishes.
    ///     Note that this must be called on the main thread since it updates
    ///     the UI.
    ///
    func fetchAlbums(completionHandler: FirebaseFetchCompletion) {
        let downloadTask = NSURLSession.sharedSession().dataTaskWithURL(albumsURL) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let json = self.extractJSONFromData(data) else {
                    return
                }
                let albums = self.extractAlbumsFromJSON(json)
                completionHandler(albums, nil)
            }
        }
        downloadTask.resume()
    }
    
    ///
    /// Adds an album to Firebase.  The Firebase response returns the album ID
    /// with the key "name".  We don't need it so we just ignore it.
    /// - parameter album: the album to add to Firebase
    /// - completionHandler: the method that processes the Firebase response
    ///
    func saveAlbum(album: Album, completionHandler: FirebaseSaveCompletion) {
        guard let data = self.createDataFromAlbum(album) else {
            return
        }
        let request = NSMutableURLRequest(URL: albumsURL)
        request.HTTPMethod = "POST"
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        let uploadTask = session.uploadTaskWithRequest(request, fromData: data) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(error)
            }
        }
        uploadTask.resume()
    }
    
    ///
    /// Deletes an album from Firebase using the album ID.
    /// - parameter album: the album to be deleted
    /// - parameter completionHandler:
    ///
    func deleteAlbum(album: Album, completionHandler: FirebaseDeleteCompletion) {
        guard let albumID = album.id else {
            completionHandler(NSError(domain: "albums", code: 103, userInfo: nil))
            return
        }
        let deleteUrlComponents = NSURLComponents()
        deleteUrlComponents.host = self.urlComponents.host
        deleteUrlComponents.path = "/albums/\(albumID).json"
        deleteUrlComponents.scheme = "https"
        
        let deleteRequest = NSMutableURLRequest(URL: deleteUrlComponents.URL!)
        deleteRequest.HTTPMethod = "DELETE"
        
        let deleteTask = NSURLSession.sharedSession().dataTaskWithRequest(deleteRequest) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(error)
            }
        }
        deleteTask.resume()
    }
    
    ///
    /// Extracts an array of Albums from the JSON received from Firebase.
    /// - parameter json: the JSON received from Firebase
    /// - returns: an array of Albums
    ///
    func extractAlbumsFromJSON(json: [String: AnyObject]) -> [Album] {
        var albums: [Album] = []
        for (key, item) in json {
            if let item = item as? [String: String] {
                let album = Album(band: item["band"]!,
                                  title: item["title"]!)
                album.id = key
                albums.append(album)
            }
        }
        return albums
    }
    
    ///
    /// Extracts JSON from the data received from Firebase.
    /// - parameter data: the data received from Firebase
    /// - returns: the data as a dictionary.  Nil if unable to parse the data.
    ///
    func extractJSONFromData(data: AnyObject?) -> [String: AnyObject]? {
        guard let data = data as! NSData? else {
            return nil
        }
        var json:AnyObject? = nil
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        } catch {
            return nil
        }
        return json as? [String: AnyObject]
    }
    
    ///
    /// Creates a data description of an album.  First convert to JSON, then
    /// serialize.
    /// - parameter album: the album to be converted to data
    /// - returns: data representation of album
    ///
    func createDataFromAlbum(album: Album) -> NSData? {
        var data: NSData? = nil
        do {
            try data = NSJSONSerialization.dataWithJSONObject(album.toJSON(), options: NSJSONWritingOptions(rawValue: 0))
        } catch {
            return nil
        }
        return data
    }
}
