//
//  SettingsViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

enum CellTags: Int {
    case sound = 1
    case allowUseLocation = 2
    case changePassword = 3
    case sortPlacesByName = 4
    case useCelsius = 5
}

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
            let rect = CGRect(x: imageScroll.bounds.width * CGFloat(i),
                              y: 0,
                              width: imageScroll.frame.width,
                              height: imageScroll.frame.height)
            
            let imageView = UIImageView(frame: rect)
            imageView.contentMode = .scaleAspectFill
            imageView.image = styleManager.backgroundThemeArray[i]
            
            imageScroll.contentSize.width = imageScroll.bounds.width * CGFloat(i + 1)
            imageScroll.addSubview(imageView)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        for i in 0 ..< imageScroll.subviews.count {
            let rect = CGRect(x: size.width * CGFloat(i),
                              y: 0,
                              width: size.width,
                              height: imageScroll.frame.height)
            imageScroll.subviews[i].frame = rect
            imageScroll.contentSize.width = size.width * CGFloat(i + 1)
        }
        
        let pointOffset = CGPoint(x: size.width * CGFloat(currentPage ?? 0), y: 0)
        imageScroll.setContentOffset(pointOffset, animated: true)
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
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            notifyAboutChanges(with: cell.tag, value: false)
        } else if cell.accessoryType == UITableViewCellAccessoryType.none {
            cell.accessoryType = .checkmark
            notifyAboutChanges(with: cell.tag, value: true)
        }
    }
    
    func notifyAboutChanges(with cellTag: Int, value: Bool) {
        switch  cellTag {
        case CellTags.sound.rawValue:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.sound.rawValue)
            NotificationCenter.default.post(name: Constants.isMakeSound, object: nil)
        case CellTags.allowUseLocation.rawValue:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.userLocation.rawValue)
        case CellTags.sortPlacesByName.rawValue:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.sortPlaces.rawValue)
        case CellTags.useCelsius.rawValue:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.celcius.rawValue)
        default:
            break
        }
    }
}



