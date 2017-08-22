//
//  SettingsViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var imageScroll: UIScrollView!
    
    let backgroundThemeArray = [#imageLiteral(resourceName: "background"), #imageLiteral(resourceName: "back"), #imageLiteral(resourceName: "profileBackground")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0 ..< backgroundThemeArray.count {
            let imageView = UIImageView()
            imageView.image = backgroundThemeArray[i]
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: imageScroll.frame.width,
                                     height: imageScroll.frame.height)
            
            imageScroll.contentSize.width = imageScroll.frame.width * CGFloat(i + 1)
            imageScroll.addSubview(imageView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.scrollRectToVisible(scrollView.subviews[2].bounds, animated: true)
    }
}
