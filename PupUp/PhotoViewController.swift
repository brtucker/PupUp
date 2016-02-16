//
//  PhotoViewController.swift
//  PupUp
//
//  Created by Blake Tucker on 2/15/16.
//  Copyright © 2016 Blake Tucker. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    var photo: FlickrPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView.image = self.photo?.thumbnail
        getLargeImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLargeImage() {
        self.photo?.loadLargeImage({
            flickrPhoto, error in
            
            print("Downloading large image")
            
            if error != nil {
                print("Error searching: \(error)")
            }
            if flickrPhoto.largeImage != nil {
                print("Large imaged downladed")
                self.photoView.image = self.photo?.largeImage
            }
            
        })
    }

}
