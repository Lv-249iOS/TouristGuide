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
    public var imageUrlString: String?
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = imageUrlString {
            ImageDownloader.shared.downloadImage(with: url) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
