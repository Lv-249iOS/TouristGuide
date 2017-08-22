//
//  ValidateInput.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/22/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

class ValidateInput {
    static let shared = ValidateInput()
    
    private var database = UserCoreData()
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func emailExists(testStr: String) -> Bool {
        if let _ = database.getUser(by: testStr) {
            return true
        }
        return false
    }
}
