//
//  CoreDataWorker.swift
//  Super Weather
//
//  Created by Игорь Силаев on 23.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import CoreData

protocol DataWorker {
    func createCityEntity(_ city: CityModel)
    func retrieveCityEntities() -> [CityEntity]?
    func deleteCityEntity(_ cityName: String)
}

final class CoreDataWorker: NSObject, DataWorker {
    
    //MARK: - Private properties
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Super_Weather")
        container.loadPersistentStores { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                fatalError("Loading store failed \(error)")
            }
        }
        return container
    }()
    
    private enum Keys {
        static let city = "CityEntity"
    }
    
    private var fetcherResultsController: NSFetchedResultsController<CityEntity>?
    private var context: NSManagedObjectContext
    
    
    // MARK: - Initialization
    
    required init(neededContext: Bool = false) {
        if neededContext {
            context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        } else {
            context = persistentContainer.viewContext
        }
    }
    
    // MARK: - Private methods
    
    private func setupFetcherResultsController(for context: NSManagedObjectContext) {
        let sortDescriptor = NSSortDescriptor(key: "cityName", ascending: true)
        let request = NSFetchRequest<CityEntity>(entityName: Keys.city)
        request.sortDescriptors = [sortDescriptor]
        
        fetcherResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetcherResultsController?.delegate = self
    }
    
    
    // MARK: - City CRUD
    
    func createCityEntity(_ city: CityModel) {
        
        guard let newCity = NSEntityDescription.insertNewObject(forEntityName: Keys.city, into: context) as? CityEntity else { return }
        
        newCity.cityName = city.cityName
        
        do {
            try context.save()
        } catch {
            print("Failed to create city: \(error)")
        }
    }
    
    func retrieveCityEntities() -> [CityEntity]? {
        
        setupFetcherResultsController(for: context)
        do {
            try fetcherResultsController?.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        
        return fetcherResultsController?.fetchedObjects
    }
    
    func deleteCityEntity(_ cityName: String) {
        
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

extension CoreDataWorker: NSFetchedResultsControllerDelegate {

}
