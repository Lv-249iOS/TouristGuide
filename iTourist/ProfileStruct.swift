//
//  ProfileStruct.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation

struct User {
    public var name: String? = ""
    public var surname: String? = ""
    public var email: String? = ""
    public var password: String? = ""
    public var image: NSData? = nil
    public var instanceToChange: UserType = UserType.none

}

enum UserType {
    case name
    case surname
    case email
    case password
    case image
    case none
}
