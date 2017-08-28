//
//  ProfileStruct.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

struct User {
    var name: String? = ""
    var surname: String? = ""
    var email: String? = ""
    var password: String? = ""
    var phone: String? = ""
    var image: NSData? = nil
    var instanceToChange: UserType = UserType.none
    
}

enum UserType {
    case name
    case surname
    case email
    case password
    case image
    case phone
    case none
}
