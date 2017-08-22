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
    var currentPage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillImageScrollView()
    }
    
    func fillImageScrollView() {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        let pointOffset = CGPoint(x: view.frame.width * CGFloat(styleManager.currentPage), y: 0)
        imageScroll.setContentOffset(pointOffset, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let page = currentPage {
            styleManager.currentPage = page
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}
