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
    
    func add(data: [NSData], key: String) {
        PlaceCoreData.persistentContainer.performBackgroundTask({ context in
            if let place = NSEntityDescription.insertNewObject(forEntityName: "PlaceEntity", into: context) as? PlaceEntity {
                place.key = key
                place.data = data as NSArray
            }
            try? context.save()
            
            DispatchQueue.main.async { [weak self] in
                guard self != nil else {
                    print("Self is nil ")
                    return
                }
            }
        })
    }
    
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





















