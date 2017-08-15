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
    
    func add(user: User) {
        if let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: UserCoreData.context) as? UserEntity {
            newUser.name = user.name
            newUser.surname = user.surname
            newUser.email = user.email
            newUser.password = user.password
            newUser.image = user.image
        }
        try? UserCoreData.context.save()
        
        DispatchQueue.main.async { [weak self] in
            guard self != nil else {
                print("Self is nil ")
                return
            }
        }
    }


func getUser(by email: String) -> User? {
    let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
    userFetch.predicate = NSPredicate(format: "email == %@", email)
    do {
        let result = try UserCoreData.context.fetch(userFetch)
        if result.count > 0 {
            var currentUser = NSManagedObject(entity: entity!, insertInto: UserCoreData.context)
            currentUser = result.first as! NSManagedObject
            var user: User?
            user?.name = currentUser.value(forKey: "name") as? String
            user?.surname = currentUser.value(forKey: "surname") as? String
            user?.email = currentUser.value(forKey: "email") as? String
            user?.password = currentUser.value(forKey: "password") as? String
            user?.image = currentUser.value(forKey: "image")
             as? NSData
            return user
        } else {
            print("Eror: User by login not found")
            try UserCoreData.context.save()
        }
    } catch let error as NSError {
        print("Error: \(error) " +
            "description \(error.localizedDescription)")
  }
    return nil
}

    func delete(for login: String) {
        DispatchQueue.global(qos: .background).async {
            let predicate = NSPredicate(format: "login == %@", login)
            let fetchToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
            fetchToDelete.predicate = predicate
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchToDelete)
            do {
                try UserCoreData.persistentContainer.newBackgroundContext().execute(deleteRequest)
            } catch {
                print ("There was an error during deleting")
            }
        }
    }
    func changeUsersData(for login: String,user: User) {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
//            fetchRequest.predicate = NSPredicate(format: "login = %@", login)
//            if let fetchResults = try? UserCoreData.context.fetch(fetchRequest) as? [NSManagedObject] {
//                if fetchResults?.count != 0 {
//                    var currentUser = fetchResults?[0]
//                    if (user.name != nil) {
//                        currentUser?.setValue(user.name, forKey: "name")
//                    }
//                    if (user.surname != nil) {
//                        currentUser?.setValue(user.name, forKey: "name")
//                    }
//                    if (user.image != nil) {
//                        currentUser?.setValue(user.name, forKey: "name")
//                    }
//                    if (user.password != nil) {
//                        currentUser?.setValue(user.name, forKey: "name")
//                    }
//                    UserCoreData.context.save()
//                    
//                }
//            }
//    }
}
}
