//
//  UserCoreDataTests.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import XCTest
@testable import iTourist

class UserCoreDataTests: XCTestCase {
    let userController = UserCoreData()
    
    func testAddingAndGettingUser() {
        var user = User()
        user.name = "Working"
        user.email = "Email_Test"
        user.password = "password test"
        user.surname = "test surname"
        userController.addUser(user: user)
        
        let getUser = userController.getUser(by: "Email_Test")
        XCTAssertEqual(getUser?.name, "Working")
    }
    
    func testDeletingData() {
        var user = User()
        user.name = "Check1 for deleting"
        user.email = "ta5sdfghjkl"
        user.password = "password test"
        user.surname = "test surname"
        
        userController.addUser(user: user)
        userController.deleteUser(for: user.email!)
        let testDel = userController.getUser(by: user.email!)
        XCTAssertEqual(testDel?.name!, nil)
    }
    func testChangingInstance() {
        var user = User()
        user.name = "ChangeName"
        user.email = "ChangeEmail"
        user.password = "ChangePassword"
        user.surname = "ChangeSurname"
        userController.addUser(user: user)
        let get1 = userController.getUser(by: user.email!)
        XCTAssertEqual(user.name, get1?.name)
        user.instanceToChange = UserType.name
        user.name = "Name was changed"
        userController.changeUserData(for: user.email!, user: user)
        let get2 = userController.getUser(by: user.email!)
        XCTAssertEqual("Name was changed", get2?.name)
        
    }
    
}
