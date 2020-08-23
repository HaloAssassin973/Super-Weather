//
//  CoreDataWorker.swift
//  Super Weather
//
//  Created by Игорь Силаев on 23.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import CoreData

final class CoreDataManager {
    
    
    // MARK: - Public properties
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Super_Weather")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading store failed \(error)")
            }
        }
        return container
    }()
    
    
    //MARK: - Private properties
    
    private enum Keys {
        static let city = "CityEntity"
    }
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: - City CRUD
    
    private func createCityEntity(_ city: CityModel) {
        
        let newCity = NSEntityDescription.insertNewObject(forEntityName: Keys.city, into: context) as! CityEntity
        
        newCity.cityName = city.cityName
        
        do {
            try context.save()
        } catch {
            print("Failed to create city: \(error)")
        }
    }
    
    private func retrieveCityEntities() -> [CityModel]? {
        
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: Keys.city)
        do {
            let cities = try context.fetch(fetchRequest)
            
            var result: [CityModel] = []
            for city in cities {
                guard let cityName = city.cityName else { return nil }
                let cityModel = CityModel(cityName: cityName)
                result.append(cityModel)
            }
            return result
        } catch {
            print("Failed to get city: \(error)")
        }
        return nil
    }
    
    private func deleteCityEntity(_ cityName: String) {
        
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: Keys.city)
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", cityName)
        do {
            if let city = try context.fetch(fetchRequest).first {
                context.delete(city)
                try context.save()
            }
        } catch {
            print("Failed to delete city: \(error)")
        }
    }
}

