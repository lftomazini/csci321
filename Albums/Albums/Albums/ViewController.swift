//
//  ViewController.swift
//  Albums
//
//  Created by Rick Zaccone
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import UIKit

///
/// ViewController is responsible for displaying a table containing a list of
/// Albums.
///
class ViewController: UITableViewController {
    
    let firebase = Firebase(hostName: "intense-heat-1938.firebaseio.com")
    var albums: [Album] = []
    
    ///
    /// Loads the table data.
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
    }
    
    ///
    /// Fetches the list of albums from Firebase and displays them.
    ///
    private func reloadData() {
        firebase.fetchAlbums { (albums, error) in
            if let error = error {
                self.showAlert(error)
            } else {
                if let albums = albums {
                    self.albums = albums
                    self.albums.sortInPlace { $0 < $1 }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    ///
    /// Displays an alert when an error occurs.
    /// - parameter error: the error that occurred
    ///
    private func showAlert(error: NSError) {
        let alert = UIAlertController(title: "Oops!", message: "Could not fetch albums data.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK" , style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Table view data source
    
    ///
    /// There's a row for each album so the number of rows is the number of
    /// albums.
    ///
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    ///
    /// Initializes the cell with the album title and band.
    ///
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell") as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AlbumCell")
        }
        cell!.textLabel?.text = albums[indexPath.row].description
        return cell!
    }
    
    ///
    /// Allow editing of the table.
    ///
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    ///
    /// Deletes an album from the table.
    ///
    override func tableView(
        tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                           forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let album = albums[indexPath.row]
            firebase.deleteAlbum(album, completionHandler: { (error) in
                if let error = error {
                    self.showAlert(error)
                } else {
                    self.albums.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath],
                        withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            })
        }
    }
    
    // MARK: Add album
    
    ///
    /// Responds to a tap on the cancel button.  Do nothing.
    /// - parameter segue: the storyboard segue
    ///
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    
    ///
    /// Responds to a tap on the add button.  Extracts the album info from the
    /// AddAlbumViewController and saves it to Firebase.
    /// - parameter segue: the segue that got us here
    ///
    @IBAction func add(segue: UIStoryboardSegue) {
        let detailController = segue.sourceViewController as! AddAlbumViewController
        firebase.saveAlbum(detailController.album) { (error) in
            if let error = error {
                self.showAlert(error)
            } else {
                self.reloadData()
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}