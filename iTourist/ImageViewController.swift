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
    
    var imageManager = ImageManager.shared
    var imageUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = imageUrlString {
            imageManager.obtainImage(with: url) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
