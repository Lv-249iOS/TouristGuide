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
    var currentPage: Int = 0
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
