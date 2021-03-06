//
//  StyleManager.swift
//  iTourist
//
//  Created by Alejandro Del Rio Albrechet on 8/22/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsManager {
    
    static var shared = SettingsManager()
    
    enum PathForKey: String {
        case currentPageOfImage = "currentPageOfImage"
    }
    
    var backgroundThemeArray = [
        #imageLiteral(resourceName: "city"),
        #imageLiteral(resourceName: "city1"),
        #imageLiteral(resourceName: "city2"),
        #imageLiteral(resourceName: "city3"),
        #imageLiteral(resourceName: "background"),
        #imageLiteral(resourceName: "profileBackground")
    ]
    
    var currentPage: Int {
        get {
            if let value = UserDefaults.standard.value(forKey: PathForKey.currentPageOfImage.rawValue) as? Int {
                return value
            } else {
                return 0
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PathForKey.currentPageOfImage.rawValue)
        }
    }
    
    var currentBackgroundImage: UIImage {
        return backgroundThemeArray[currentPage]
    }
    
    func makeSoundIfNeeded() {
        if let val = UserDefaults.standard.value(forKey: PathForSettingsKey.sound.rawValue) as? Bool,
            val == true {
            AudioServicesPlaySystemSound(1105)
        }
    }
}
