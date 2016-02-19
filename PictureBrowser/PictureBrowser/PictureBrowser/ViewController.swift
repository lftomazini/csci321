//
//  ViewController.swift
//  PictureBrowser
//
//  Created by Luís Felipe on 2/17/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var thumbnailCollection: UICollectionView!
    /// The names of the files in the thumbnail directory
    var fileList: [String] = []
    /// The name of the thumbnail directory
    let thumbnailDirectory = "Bucknell In the Virgin Islands thumb"
    /// The name of the full size image directory
    let fullSizeImageDirectory = "Bucknell In the Virgin Islands full"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFileList()
        title = "Virgin Islands"
    }

    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFileList(){
        let thumbnailPath = thumbnailDirectoryPath()
        let defaultFileManager = NSFileManager.defaultManager()
        do {
            let thumbnailList = try defaultFileManager.contentsOfDirectoryAtPath(thumbnailPath)
            for fileName in thumbnailList {
                fileList.append(fileName)
            }
        }
        catch let error as NSError {
            print("\(__FUNCTION__): \(error.description)")
        }
    }
    
    /// Finds a path to the thumbnail directory. The thumbnail directory is 
    /// a subdirectory of the app's resource path.
    ///
    /// - returns: the path to the thumbnail directory
    ///
    func thumbnailDirectoryPath() -> String {
        return resourcePath().stringByAppendingPathComponent(thumbnailDirectory)
    }
    
    ///
    /// Finds a path to the thumbnail directory. The thumbnail directory is 
    /// a subdirectory of the app's resource path.
    ///
    /// - returns: the path to the thumbnail directory
    ///
    func fullImageDirectoryPath() -> String {
        return resourcePath().stringByAppendingPathComponent(fullSizeImageDirectory)
    }

    /// Returns the path to the resource directory. Note: This method returns 
    /// an NSString because NSString has the method stringByAppendingPathComponent 
    /// which is useful when constructing a file path
    func resourcePath() -> NSString {
        return NSBundle.mainBundle().resourcePath!
    }
    
    ///
    /// Determines the file name of the full sized image
    /// - parameter thumbnailFileName: the name of the corresponding thumbnail file
    ///
    /// - returns: the name of the full sized image
    ///
    func fullsizedImageFileName(thumbnailFileName: NSString) -> String {
        let nameWithoutExtension = thumbnailFileName.stringByDeletingPathExtension
        let fileExtension = thumbnailFileName.pathExtension
        return nameWithoutExtension + "full." + fileExtension
    }
    
    ///
    /// Computes the path to the full sized image that corresponds to the 
    /// thumbnail image that the user tapped on.
    ///
    /// - returns: path to a full sized image
    ///
    func pathToCorrespondingFullImage() -> String {
        let thumbnailFileName = selectedThumbnailFileName()
        let fullsizedFileName = fullsizedImageFileName(thumbnailFileName)
        let filePath = (fullImageDirectoryPath() as NSString).stringByAppendingPathComponent(fullsizedFileName)
        return filePath
    }
    
    ///
    /// Determines the name of the file corresponding to the tapped thumbnail.
    ///
    /// - returns: name of the thumbnail file
    ///
    func selectedThumbnailFileName() -> String {
        let indexPath = thumbnailCollection.indexPathsForSelectedItems()!.first!
        return fileList[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileList.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = thumbnailCollection.dequeueReusableCellWithReuseIdentifier("Thumbnail", forIndexPath: indexPath) as! ThumbnailCollectionViewCell
        let fileName = (thumbnailDirectoryPath() as NSString).stringByAppendingPathComponent(fileList[indexPath.row])
        guard let image = UIImage(named: fileName) else {
            print("Image is nil for index \(indexPath.row)")
            return cell
        }
        cell.thumbnailView.image = image
        return cell
    }
}
