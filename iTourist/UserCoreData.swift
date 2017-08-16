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
    
    func changeUserData(for email: String, user: User) {
        let asyncRequest = NSBatchUpdateRequest(entityName: "UserEntity")
        switch user.instanceToChange {
        case .name : asyncRequest.propertiesToUpdate = [ "name" : user.name ?? "" ]
        case .surname: asyncRequest.propertiesToUpdate = [ "surname" : user.surname ?? "" ]
        case .password: asyncRequest.propertiesToUpdate = [ "email" : user.password ?? "" ]
        case .image: asyncRequest.propertiesToUpdate = [ "image" : user.image! ]
        default: break
        }
        asyncRequest.resultType = .updatedObjectIDsResultType
        asyncRequest.predicate = NSPredicate(format: "email == %@", email)
        let batchUpdateResult = try? UserCoreData.context.execute(asyncRequest) as! NSBatchUpdateResult
        if ((batchUpdateResult?.result) != nil) {
            let objectID = batchUpdateResult?.result as? [NSManagedObjectID]
            if objectID?.first != nil {
                let managedObject = UserCoreData.context.object(with: (objectID?.first)!)
                UserCoreData.context.refresh(managedObject, mergeChanges: false)
            }
        }
    }
    
}
