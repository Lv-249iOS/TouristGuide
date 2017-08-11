//
//  ImageViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    public var image: UIImage?
    var imageLoader = ImageDownloader.shared
    var place: Place?
    
}
