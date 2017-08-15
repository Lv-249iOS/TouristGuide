//
//  ProfileStruct.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

struct User {
    var name: String? = nil
    var surname: String? = nil
    var email: String? = nil
    var password: String? = nil
    var image: NSData? = nil
}
enum UserType {
    case name
    case surname
    case email
    case password
    case image
}
