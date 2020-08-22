//
//  WeatherModuleInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import CoreLocation
import UIKit

protocol WeatherModuleDadaSource: class {
    
}

protocol WeatherModuleBusinessLogic: class {
    
    ///описание
    func handleViewReady()
    
    ///описание
    func retrieveInitioalData()
    
    ///описание
    func fetchWeather(_ request: WeatherModels.Fetch.Request)
    
    ///описание
    func handleSearch()
    
    ///описание
    func handleTapCity(name: String)
}


final class WeatherModuleInteractor: NSObject, WeatherModuleDadaSource {
    
    //MARK: - Public properties
    
    var presenter: WeatherModulePresentationLogic!
    
    
    //MARK: - Pivate properties
    
    private lazy var dataFetcher = NetworkDataFetcher()
    private lazy var locationManager = LocationWorker(client: self)
    private lazy var imageWorker = ImageWorker()
    
    
    //MARK: - Pivate methods
    
    private func fetchWeatherWithLocation() {
        guard let location = locationManager.exposedLocation else {
            print("Location is nil")
            return
        }
        locationManager.getPlace(for: location) { [weak self] (placemark) in
            guard let self = self, let city = placemark?.locality?.applyingTransform(.toLatin, reverse: false) else { return }
            self.dataFetcher.fetchWeather(searchTerm: city) { [weak self] weather in
                self?.presenter.presentLoading(isActive: false)
                guard let iconID = weather?.weather.first?.icon else { return }
                self?.imageWorker.getImage(with: iconID) { [weak self] (data, error) in
                    guard let iconData = data else { return }
                    let icon = UIImage(data: iconData)
                    self?.presenter.presentWeather(WeatherModels.Fetch.Response(weather: weather, icon: icon, errorMessage: nil))
                }
            }
        }
    }
}


// MARK: - Weather Module Business Logic

extension WeatherModuleInteractor: WeatherModuleBusinessLogic {
    func retrieveInitioalData() {
        
    }
    
    func handleSearch() {
        
    }
    
    func handleTapCity(name: String) {
        
    }
    
    
    func handleViewReady() {
        presenter.presentLoading(isActive: true)
        //start location search
        fetchWeatherWithLocation()
    }
    
    func fetchWeather(_ request: WeatherModels.Fetch.Request) {
        dataFetcher.fetchWeather(searchTerm: request.city) { [weak self] weather in
            guard let iconID = weather?.weather.first?.icon else { return }
            self?.imageWorker.getImage(with: iconID) { [weak self] (data, error) in
                guard let iconData = data else { return }
                let icon = UIImage(data: iconData)
                self?.presenter.presentWeather(WeatherModels.Fetch.Response(weather: weather, icon: icon, errorMessage: nil))
            }
        }
    }
}

// MARK: - CoreLocation Delegate

extension WeatherModuleInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            fetchWeatherWithLocation()
        case .authorizedAlways:
            print("authorizedAlways")
        case .restricted:
            print("restricted")           
        case .denied:
            print("denied")
        @unknown default:
            print("New Status")
        }
    }
}
