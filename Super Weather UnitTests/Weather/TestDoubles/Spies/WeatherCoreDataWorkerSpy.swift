//
//  WeatherCoreDataWorkerSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 03.09.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
import CoreData
@testable import Super_Weather

final class WeatherCoreDataWorkerSpy: DataWorker {
    
    // MARK: - Private Properties
    
    private(set) var isCalledCreateCityEntity = false
    private(set) var isCalledRetrieveCityEntitiesFetchController = false
    private(set) var isCalledDeleteCityEntity = false
    
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
    
    
    // MARK: - Public Methods
    
    func createCityEntity(_ city: CityModel) {
        isCalledCreateCityEntity = true
    }
    
    func retrieveCityEntitiesFetchController() -> NSFetchedResultsController<CityEntity> {
        
        isCalledRetrieveCityEntitiesFetchController = true
        
        let sortDescriptor = NSSortDescriptor(key: "cityName", ascending: true)
        let request = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        request.sortDescriptors = [sortDescriptor]
        
        let context = persistentContainer.viewContext
        
        let fetcherResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetcherResultsController
    }
    
    func deleteCityEntity(_ cityName: String) {
        isCalledDeleteCityEntity = true
    }
    
}
