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
        
        let place = NSManagedObject(entity: entity!, insertInto: PlaceCoreData.context)
        place.setValue(data, forKey: "data")
        place.setValue(key, forKey: "key")
        do {
            try PlaceCoreData.context.save()
            self.places.append(place)
        }
        catch {
            print("Error in saving data")
        }
    }
    
    func get(by key: String) -> [NSData] {
        let placeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceEntity")
        placeFetch.predicate = NSPredicate(format: "key == %@", key)
        do {
            let result = try PlaceCoreData.context.fetch(placeFetch)
            if result.count > 0 {
                var place = NSManagedObject(entity: entity!, insertInto: PlaceCoreData.context)
                place = result.first as! NSManagedObject
                
                return place.value(forKey: "data") as! [NSData]
            } else {
                print("Eror: Place by key not found")
                try PlaceCoreData.context.save()
            }
        } catch let error as NSError {
            print("Error: \(error) " +
                "description \(error.localizedDescription)")
        }
        
        return []
    }
    
    func delete(for key: String) -> Bool {
        let predicate = NSPredicate(format: "key == %@", key)
        let fetchToDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceEntity")
        fetchToDelete.predicate = predicate
        do {
            let fetchedEntities = try PlaceCoreData.context.fetch(fetchToDelete) as! [NSManagedObject]
            if let entityToDelete = fetchedEntities.first {
                PlaceCoreData.context.delete(entityToDelete)
                try PlaceCoreData.context.save()
                return true
            }
        } catch let error as NSError {
            print("Error: \(error) " + "description \(error.localizedDescription)")
        }
        
        return false
    }
}




















