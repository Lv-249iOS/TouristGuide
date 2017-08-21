//
//  UserCoreData.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserCoreData {
    
    private var users = [NSManagedObject]()
    private let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
    
    private static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    private static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    /**
    This method add new user to User Database.
     
     - parameter user: User is the object of custom struct User, where defined instances name, surname, email and etc.
     
     */
    func addUser(user: User) {
        if let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: UserCoreData.context) as? UserEntity {
            newUser.name = user.name
            newUser.surname = user.surname
            newUser.email = user.email
            newUser.password = user.password
            newUser.image = user.image
        }
        try? UserCoreData.context.save()
    }
    /**
     This method allows you to get all information about user by custom struct User.
     
     - parameter email: The email is unique indentifier of each user
     
     */
    func getUser(by email: String) -> User? {
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        userFetch.predicate = NSPredicate(format: "email == %@", email)
        do {
            let result = try UserCoreData.context.fetch(userFetch)
            if result.count > 0 {
                var currentUser = NSManagedObject(entity: entity!, insertInto: UserCoreData.context)
                currentUser = result.first as! NSManagedObject
                var user = User()
                user.name = currentUser.value(forKey: "name") as? String
                user.surname = currentUser.value(forKey: "surname") as? String
                user.email = currentUser.value(forKey: "email") as? String
                user.password = currentUser.value(forKey: "password") as? String
                user.image = currentUser.value(forKey: "image") as? NSData
                return user
            } else {
                print("Eror: User by email not found")
                try UserCoreData.context.save()
            }
        } catch let error as NSError {
            print("Error: \(error) " +
                "description \(error.localizedDescription)")
        }
        return nil
    }
    /**
     This method allows you to delete user from CoreData.
     
     - parameter email: The email is unique indentifier of each user.
     
     */
    func deleteUser(for email: String) {
        let predicate = NSPredicate(format: "email == %@", email)
        let fetchToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        fetchToDelete.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchToDelete)
        do {
            try UserCoreData.persistentContainer.newBackgroundContext().execute(deleteRequest)
        } catch {
            print ("There was an error during deleting")
        }
    }
    /**
     This method allows you to change one instance about user, you should to determine changeable value in struct. It is value named "instanceToChange"
     
     - parameter email: The email is unique indentifier of each user.
     - parameter user: User is the object of custom struct User, where defined instances name, surname, email and etc.
     
     */
    func changeUserData(for email: String, user: User) {
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: "UserEntity")
        switch user.instanceToChange {
        case .name : batchUpdateRequest.propertiesToUpdate = [ "name" : user.name ?? "" ]
        case .surname: batchUpdateRequest.propertiesToUpdate = [ "surname" : user.surname ?? "" ]
        case .password: batchUpdateRequest.propertiesToUpdate = [ "email" : user.password ?? "" ]
        case .image: batchUpdateRequest.propertiesToUpdate = [ "image" : user.image! ]
        default: return
        }
        batchUpdateRequest.resultType = .updatedObjectIDsResultType
        batchUpdateRequest.predicate = NSPredicate(format: "email == %@", email)
        let batchUpdateResult = try? UserCoreData.context.execute(batchUpdateRequest) as! NSBatchUpdateResult
        if ((batchUpdateResult?.result) != nil) {
            let objectID = batchUpdateResult?.result as? [NSManagedObjectID]
            if objectID?.first != nil {
                let managedObject = UserCoreData.context.object(with: (objectID?.first)!)
                UserCoreData.context.refresh(managedObject, mergeChanges: false)
            }
        }
    }
}
