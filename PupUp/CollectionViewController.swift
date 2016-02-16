//
//  CollectionViewController.swift
//  PupUp
//
//  Created by Blake Tucker on 2/13/16.
//  Copyright © 2016 Blake Tucker. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class CollectionViewController: UICollectionViewController {
    
    var searchResults = [FlickrSearchResults]()
    let downloadIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        downloadIndicator.center = self.view.center
        downloadIndicator.startAnimating()
        self.view.addSubview(downloadIndicator)
        downloadPuppyPictures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadPuppyPictures() {
        let flickr = Flickr()
        flickr.searchFlickrForTerm("doggy") {
            results, error in
            
            if error != nil {
                print("Error searching: \(error)")
            }
            
            if results != nil {
                print("Found \(results?.searchResults.count)")
                self.searchResults.insert(results!, atIndex: 0)
            }
            
            self.collectionView?.reloadData()
        }
        self.downloadIndicator.stopAnimating()
    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searchResults[indexPath.section].searchResults[indexPath.row]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewImage" {
            let viewImageController = segue.destinationViewController as! PhotoViewController
            viewImageController.photo = self.searchResults[0].searchResults[self.selectedRow!]
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchResults.count < 1 {
            return 0
        }
        else {
            return self.searchResults[0].searchResults.count
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
    
        // Configure the cell
        cell.create(self.photoForIndexPath(indexPath))
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = indexPath.row
        performSegueWithIdentifier("viewImage", sender: self)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
