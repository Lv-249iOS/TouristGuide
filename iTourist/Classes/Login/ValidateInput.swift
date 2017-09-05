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
    
    func emailExistsInDatabase(testStr: String) -> User? {
        if let user = database.getUser(by: testStr) {
            return user
        }
        return nil
    }
    
    func isValidPhoneNumper(testStr: String) -> Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: testStr)
    }
    
    func isValidPassword(testStr: String) -> Bool {
        let passwordRegEx = ".{6,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: testStr)
    }
}
