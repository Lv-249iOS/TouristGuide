//
//  UserDefaultsHelper.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/26/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case IsLoggedIn
        case Email
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
        synchronize()
    }
    
    func setEmail(value: String) {
        set(value, forKey: UserDefaultsKeys.Email.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
    }
    
    func getEmail() -> String {
        if let email = string(forKey: UserDefaultsKeys.Email.rawValue) {
            return email
        }
        
        return ""
    }
}
