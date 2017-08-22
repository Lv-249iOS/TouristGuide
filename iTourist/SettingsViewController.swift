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
    
    let styleManager = StyleManager.shared
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< styleManager.backgroundThemeArray.count {
            let imageView = UIImageView()
            imageView.image = styleManager.backgroundThemeArray[i]
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: imageScroll.frame.width,
                                     height: imageScroll.frame.height)
            
            imageScroll.contentSize.width = imageScroll.frame.width * CGFloat(i + 1)
            imageScroll.addSubview(imageView)
        }
        
        // doesn't scroll to visible
        let currentPage = styleManager.currentPage
        let rect = CGRect(x: view.frame.width * CGFloat(currentPage),
                          y: 0,
                          width: view.frame.width * CGFloat(currentPage),
                          height: view.frame.height * CGFloat(currentPage))
        
        imageScroll.scrollRectToVisible(rect, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        styleManager.currentPage = currentPage
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}
