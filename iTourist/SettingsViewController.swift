//
//  SettingsViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    enum CellTags: Int {
        case sound = 1
        case connectToFacebook = 2
        case changePassword = 3
        case sortPlacesByName = 4
        case useCelsius = 5
    }
    
    @IBOutlet weak var imageScroll: UIScrollView!
    
    let styleManager = SettingsManager.shared
    var currentPage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isStartWithLandscape()
        fillImageScrollView()
    }
    
    /// Sets current background for scrollview
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        setContentOffsetForImageScroll(with: view.frame.width)
    }
    
    /// Changes size of scroll view
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        for i in 0 ..< styleManager.backgroundThemeArray.count {
            let rect = CGRect(x: size.width * CGFloat(i),
                              y: 0,
                              width: size.width,
                              height: imageScroll.frame.height)
            
            imageScroll.subviews[i].frame = rect
            imageScroll.contentSize.width = size.width * CGFloat(i + 1)
        }
        
        setContentOffsetForImageScroll(with: size.width)
    }
    
    /// Sets current background for styleManager
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let page = currentPage {
            styleManager.currentPage = page
        }
    }
    
    /// Determines current page of scroll view
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        styleManager.makeSoundIfNeeded()
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
    func fillImageScrollView() {
        print(imageScroll.subviews.count)
        for i in 0 ..< styleManager.backgroundThemeArray.count {
            let rect = CGRect(x: view.bounds.width * CGFloat(i),
                              y: 0,
                              width: view.bounds.width,
                              height: imageScroll.frame.height)
            
            let imageView = UIImageView(frame: rect)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            imageView.image = styleManager.backgroundThemeArray[i]
            
            imageScroll.contentSize.width = view.bounds.width * CGFloat(i + 1)
            imageScroll.addSubview(imageView)
            
        }
    }
    
    // Changes width of scroll visible rect if we start with landscape
    func isStartWithLandscape() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            imageScroll.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: imageScroll.bounds.height)
            setContentOffsetForImageScroll(with: imageScroll.bounds.width)
        }
    }
    
    func setContentOffsetForImageScroll(with width: CGFloat) {
        let pointOffset = CGPoint(x: width * CGFloat(currentPage ?? styleManager.currentPage), y: 0)
        imageScroll.setContentOffset(pointOffset, animated: true)
    }
    
    /// Set/Unset checkmarks
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        styleManager.makeSoundIfNeeded()
        
        if cell.accessibilityIdentifier == "FacebookCell" {
            print("qqqqqqqq")
        } else if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            notifyAboutChanges(with: CellTags(rawValue: cell.tag)!, value: false)
        } else if cell.accessoryType == UITableViewCellAccessoryType.none {
            cell.accessoryType = .checkmark
            notifyAboutChanges(with: CellTags(rawValue: cell.tag)!, value: true)
        }
    }
    
    // Sets parameters for table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.backgroundColor = DefaultColor.lightGray
        cell.textLabel?.textColor = DefaultColor.darkGray
        
        switch indexPath.section {
        case 0:
                cell.textLabel?.text = "Sound"
                cell.accessoryType = getAccessoryType(with: .sound)
                cell.imageView?.image = #imageLiteral(resourceName: "soundIcon")
                cell.imageView?.contentMode = .scaleAspectFit
                cell.tag = CellTags.sound.rawValue
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Change password"
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = #imageLiteral(resourceName: "passwordIcon")
                cell.imageView?.contentMode = .scaleAspectFill
                cell.tag = CellTags.changePassword.rawValue
            } else {
                cell.textLabel?.text = "Connect to Facebook"
                cell.accessoryType = .none
                cell.imageView?.image = #imageLiteral(resourceName: "facebookIcon")
                cell.imageView?.contentMode = .scaleAspectFill
                cell.accessibilityIdentifier = "FacebookCell"
            }
        case 2:
            cell.textLabel?.text = "Sort places by name"
            cell.accessoryType = getAccessoryType(with: .sortPlaces)
            cell.imageView?.image = #imageLiteral(resourceName: "sortIcon")
            cell.imageView?.contentMode = .scaleAspectFill
            cell.tag = CellTags.sortPlacesByName.rawValue
            
        case 3:
            cell.textLabel?.text = "Use celcier"
            cell.accessoryType = getAccessoryType(with: .celcius)
            cell.imageView?.image = #imageLiteral(resourceName: "weatherIcon")
            cell.imageView?.contentMode = .scaleAspectFill
            cell.tag = CellTags.useCelsius.rawValue
            
        default:
            cell.textLabel?.text = "WOOOOW"
        }
        
        return cell
    }
    
    /// Gets accessory type from user defaults else returns .checkmarks
    func getAccessoryType(with key: PathForSettingsKey) -> UITableViewCellAccessoryType {
        if let value = UserDefaults.standard.value(forKey: key.rawValue), let val = value as? Bool {
            return val ? .checkmark : UITableViewCellAccessoryType.none
        }
        
        return .checkmark
    }
    
    /// Sets user defaults and post notifications
    func notifyAboutChanges(with cellTag: CellTags, value: Bool) {
        switch cellTag {
        case CellTags.sound:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.sound.rawValue)
            NotificationCenter.default.post(name: Constants.isMakeSound, object: nil)

        case CellTags.sortPlacesByName:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.sortPlaces.rawValue)
            
        case CellTags.useCelsius:
            UserDefaults.standard.set(value, forKey: PathForSettingsKey.celcius.rawValue)
            
        default:
            break
        }
    }
}



