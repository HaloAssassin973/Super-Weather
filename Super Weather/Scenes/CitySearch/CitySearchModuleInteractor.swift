//
//  CitySearchModuleInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import CoreLocation

protocol CitySearchModuleDadaSource: class {
    
}

protocol CitySearchModuleBusinessLogic: class {
    
    ///описание
    func handleViewReady()
    
    ///описание
    func retrieveInitialData()
    
    ///описание
    func fetchWeather(_ request: CitySearchModels.Fetch.Request)
    
    ///описание
    func handleSearch()
    
    ///описание
    func handleTapCity(name: String)
    
    ///описание
    func addCity(_ request: CitySearchModels.Fetch.Request)
}

final class CitySearchModuleInteractor: NSObject, CitySearchModuleDadaSource {
    
    //MARK: - Public properties
    
    var presenter: CitySearchModulePresentationLogic!
    
    
    //MARK: - Pivate properties
    
    private lazy var dataFetcher = NetworkDataFetcher()
    private lazy var locationManager = LocationWorker()
    private lazy var coreDataManager = CoreDataWorker()
    
}


// MARK: - City Search Module Business Logic

extension CitySearchModuleInteractor: CitySearchModuleBusinessLogic {
    func addCity(_ request: CitySearchModels.Fetch.Request) {
        let city = CityModel(cityName: request.city)
        coreDataManager.createCityEntity(city)
        presenter.presentWeatherModule()
    }

    func fetchWeather(_ request: CitySearchModels.Fetch.Request) {

    }
    
    func handleViewReady() {

    }
    
    func retrieveInitialData() {
        
    }
    
    func handleSearch() {
        
    }
    
    func handleTapCity(name: String) {
        
    }
    
    
}
