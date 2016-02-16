//
//  InterfaceController.swift
//  PupUpWatch Extension
//
//  Created by Blake Tucker on 2/13/16.
//  Copyright © 2016 Blake Tucker. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var puppyTable: WKInterfaceTable!
    var photos = [FlickrSearchResults]()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        downloadPuppyPictures()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
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
                self.photos.insert(results!, atIndex: 0)
            }
            
            self.puppyTable.setNumberOfRows(self.photos[0].searchResults.count, withRowType: "default")
            for (index, photo) in self.photos[0].searchResults.enumerate() {
                let row = self.puppyTable.rowControllerAtIndex(index) as! TableRowController
                row.puppyImageView.setImage(photo.thumbnail)
            }
        }
    }

}
