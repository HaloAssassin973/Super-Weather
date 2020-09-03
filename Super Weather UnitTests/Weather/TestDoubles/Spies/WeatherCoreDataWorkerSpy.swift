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
    private(set) var isCalledRetrieveCityEntities = false
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
    
    func retrieveCityEntities() -> [CityEntity]? {
        let context = persistentContainer.viewContext
        let cityEntity = CityEntity(context: context)
        cityEntity.cityName = "London"
        isCalledRetrieveCityEntities = true
        
        return [cityEntity]
    }
    
    func deleteCityEntity(_ cityName: String) {
        isCalledDeleteCityEntity = true
    }
    
}
