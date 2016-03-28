//
//  Album.swift
//  Albums
//
//  Created by Rick Zaccone
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

/// Xcode header documentation: http://ericasadun.com/2015/06/14/swift-header-documentation-in-xcode-7/

///
/// An Album instance represents an album.  You supply the band and album name.
/// Firebase supplies the id.
///
class Album: CustomStringConvertible, Comparable {
    let band: String
    let title: String
    var id: String? = nil
    
    var description: String {
        return "\(band): \(title)"
    }
    
    ///
    /// Initializes an Album instance.
    /// - parameter band: the name of the band
    /// - parameter title: the album title
    ///
    init (band: String, title: String) {
        self.band = band
        self.title = title
    }
    
    ///
    /// Creates a JSON representation of the album.
    /// - returns: a dictionary representation of the album
    ///
    func toJSON() -> [String: String] {
        return ["band": band, "title": title]
    }
}

///
/// Overloads the less than operator so we can compare albums.
/// - parameter left: left operand
/// - parameter right: right operand
/// - returns: true if left < right, false otherwise
///
func <(left: Album, right: Album) -> Bool {
    if left.band == right.band {
        return left.title < right.title
    }
    return left.band < right.band
}

///
/// Overloads the equality operator so we can compare albums.
/// - parameter left: left operand
/// - parameter right: right operand
/// - returns: true if left == right, false otherwise.
///
func ==(left: Album, right: Album) -> Bool {
    return left.band == right.band && left.title == right.title
}
