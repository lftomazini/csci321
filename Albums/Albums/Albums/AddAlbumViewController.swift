//
//  File.swift
//  Albums
//
//  Created by Luís Felipe on 3/25/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import UIKit

class AddAlbumViewController: UITableViewController {
    @IBOutlet weak var albumTitleField: UITextField!
    @IBOutlet weak var bandField: UITextField!
    var album: Album!
    
    ///
    /// Creates an Album instance with the title and band when the segue is the
    /// result of tapping on the Add button.
    ///
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddAlbum" {
            album = Album(band: bandField.text!, title: albumTitleField.text!)
        }
    }
}