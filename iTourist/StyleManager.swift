//
//  StyleManager.swift
//  iTourist
//
//  Created by Alejandro Del Rio Albrechet on 8/22/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class StyleManager {
    static var shared = StyleManager()
    
    var backgroundThemeArray = [#imageLiteral(resourceName: "background"), #imageLiteral(resourceName: "back"), #imageLiteral(resourceName: "profileBackground")]
    var currentPage: Int = 0
    
    var currentBackgroundImage: UIImage {
        return backgroundThemeArray[currentPage]
    }
}
