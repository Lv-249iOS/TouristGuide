//
//  EnumForKeyPaths.swift
//  iTourist
//
//  Created by Alejandro Del Rio Albrechet on 8/23/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

// Enum for path to state of settings item in user defaults
enum PathForSettingsKey: String {
    case sound = "isMakeSound"
    case connectToFacebook = "isConnectToFacebook"
    case sortPlaces = "isSortPlaces"
    case celcius = "isUseCelcius"
}
