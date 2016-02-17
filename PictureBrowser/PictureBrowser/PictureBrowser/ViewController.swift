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
    ///The names of the files in the thumbnail directory
    var fileList: [String] = []
    
    let thumbnailDirectory = "Bucknell in the Virgin Islands thumb"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UICollectionViewDataSource

extension ViewController {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Reporting the number of items in ection")
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
