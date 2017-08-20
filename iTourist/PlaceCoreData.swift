//
//  PlaceCoreData.swift
//  iTourist
//
//  Created by Yevhen Roman on 8/13/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlaceCoreData {
    
    private var places = [NSManagedObject]()
    private let entity = NSEntityDescription.entity(forEntityName: "PlaceEntity", in: PlaceCoreData.context)
    
    private static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    private static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    /**
     This method add an data about place by key.
     
     - parameter data: The data is the array of [NSData]
     - parameter key: The key is the unique string, which belong to unique data array
     */
    func add(data: [NSData], key: String) {
        PlaceCoreData.persistentContainer.performBackgroundTask({ context in
            if let place = NSEntityDescription.insertNewObject(forEntityName: "PlaceEntity", into: context) as? PlaceEntity {
                place.key = key
                place.data = data as NSArray
            }
            try? context.save()
        })
    }
    /**
     This method return data about places by key.
     
     - parameter key: The key is the unique string, which belong to unique data place.
     */
    func get(by key: String) -> [NSData]? {
        let placeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceEntity")
        placeFetch.predicate = NSPredicate(format: "key == %@", key)
        do {
            let result = try PlaceCoreData.context.fetch(placeFetch)
            if result.count > 0 {
                var place = NSManagedObject(entity: entity!, insertInto: PlaceCoreData.context)
                place = result.first as! NSManagedObject
                
                return place.value(forKey: "dataArray") as? [NSData]
            } else {
                print("Eror: Place by key not found")
                try PlaceCoreData.context.save()
            }
        } catch let error as NSError {
            print("Error: \(error) " +
                "description \(error.localizedDescription)")
        }
        
        return nil
    }
    /**
     This method delete data place by key.
     
     - parameter key: The key is the unique string, which belong to unique data place.
     */
    func delete(for key: String) {
            let predicate = NSPredicate(format: "key == %@", key)
            let fetchToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceEntity")
            fetchToDelete.predicate = predicate
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchToDelete)
            do {
                try PlaceCoreData.persistentContainer.newBackgroundContext().execute(deleteRequest)
            } catch {
                print ("There was an error during deleting")
            }
    }
    /**
     This method change the data in CoreData by key.
     
     - parameter data: The data is that, what will be store by key, which is exist in CoreData
     - parameter key: The key is exist in CoreData and belong to some data in CoreData
     */
    func change(data: [NSData],by key: String) {
        let placeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceEntity")
        placeFetch.predicate = NSPredicate(format: "key == %@", key)
        do {
            let result = try PlaceCoreData.context.fetch(placeFetch)
            if result.count > 0 {
                delete(for: key)
                add(data: data, key: key)
            } else {
                print("Eror: Place by key not updated")
                try PlaceCoreData.context.save()
            }
        } catch let error as NSError {
            print("Error: \(error) " +
                "description \(error.localizedDescription)")
        }
    }
}


















