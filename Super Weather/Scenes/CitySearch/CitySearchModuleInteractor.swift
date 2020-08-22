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
    func retrieveInitioalData()
    
    ///описание
    func fetchWeather(_ request: CitySearchModels.Fetch.Request)
    
    ///описание
    func handleSearch()
    
    ///описание
    func handleTapCity(name: String)
}

final class CitySearchModuleInteractor: NSObject, CitySearchModuleDadaSource {
    
    //MARK: - Public properties
    
    var presenter: CitySearchModulePresentationLogic!
    
    
    //MARK: - Pivate properties
    
    private lazy var dataFetcher = NetworkDataFetcher()
    private lazy var locationManager = LocationWorker(client: self)
    
}


// MARK: - City Search Module Business Logic

extension CitySearchModuleInteractor: CitySearchModuleBusinessLogic {
    func fetchWeather(_ request: CitySearchModels.Fetch.Request) {
        dataFetcher.fetchWeather(searchTerm: request.city) { [weak self] data in
            self?.presenter.presentWeather(CitySearchModels.Fetch.Response(weather: data, errorMessage: nil))
        }
    }
    
    func handleViewReady() {
        print("view ready")
    }
    
    func retrieveInitioalData() {
        
    }
    
    func handleSearch() {
        
    }
    
    func handleTapCity(name: String) {
        
    }
    
    
}


// MARK: - CoreLocation Delegate

extension CitySearchModuleInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .authorizedAlways:
            print("authorizedAlways")
        case .restricted:
            print("restricted")           // TODO: handler
        case .denied:
            print("denied")               // TODO: handler
        @unknown default:
            print("New Status")
        }
    }
}