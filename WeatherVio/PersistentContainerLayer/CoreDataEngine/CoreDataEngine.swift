//
//  CoreDataEngine.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/21/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation
import CoreData


protocol coreDataEngineProtocol {
    func FetchCitiesCoreData(completion: @escaping([CityDB]?) -> Void)
}



class CoreDataEngine: coreDataEngineProtocol {
    
    
    static let shared = CoreDataEngine()
    
    
    
    // MARK: - Core Data stack -
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: coreData.entity)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support -
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    // MARK: - Funcations -
    // Save city to coreData
    func saveCity(cityVM: ResultViewModel) {
        let context = persistentContainer.viewContext
        let city = Cities(context: context)
        city.setValue(cityVM.address!, forKey: "city")
        city.setValue(cityVM.lat!, forKey: "lat")
        city.setValue(cityVM.lon!, forKey: "lon")
        do {
            try context.save()
        } catch {}
    }
    
    // Delete city from coreData
    func DeleteCity(city: String, completion: @escaping(Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: coreData.entity)
        fetchRequest.predicate = .init(format: "city = %@", "\(city)")
        do {
            let context = persistentContainer.viewContext
            let objects = try context.fetch(fetchRequest)
            for objec in objects {
                context.delete(objec as! Cities)
                try context.save()
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    // Fetch cities from coreData
    func FetchCitiesCoreData(completion: @escaping([CityDB]?) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: coreData.entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let context = self.persistentContainer.viewContext
            let data = try context.fetch(fetchRequest)
            var cities = [CityDB]()
            for city in data as! [Cities] {
                var model = CityDB()
                model.city      = city.city
                model.lat       = city.lat
                model.lon       = city.lon
                cities.append(model)
            }
            completion(cities)
        } catch {
            completion(nil)
        }
    }
    
    
    
}


extension NSManagedObjectContext {
    func update() throws {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self
        context.perform({
            do {
                try context.save()
            } catch {
                print(error)
            }
        })
    }
}
