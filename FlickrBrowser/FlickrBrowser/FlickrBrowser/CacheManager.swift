//
//  CacheManager.swift
//  FlickrBrowser
//
//  Created by Luís Felipe on 3/9/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class CacheManager: NSObject, NSCacheDelegate {
    static let sharedInstance = CacheManager()
    private let cache = NSCache()
    
    func setCache(data: NSPurgeableData, forKey key: String) {
        cache.setObject(data, forKey: key)
    }
    
    func getCache(key: String) -> NSPurgeableData? {
        return (cache.objectForKey(key) == nil) ? nil : cache.objectForKey(key) as? NSPurgeableData
    }

}
