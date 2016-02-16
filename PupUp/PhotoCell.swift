//
//  PhotoCell.swift
//  PupUp
//
//  Created by Blake Tucker on 2/15/16.
//  Copyright © 2016 Blake Tucker. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    var flickrPhoto: FlickrPhoto?
    
    func create(photo: FlickrPhoto) {
        self.flickrPhoto = photo
        self.photoView.image = photo.thumbnail
    }
}
