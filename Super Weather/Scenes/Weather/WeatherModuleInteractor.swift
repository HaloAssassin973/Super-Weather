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
    
    ///Метод вызываемой при готов View
    func handleViewReady()
    
    ///Получение данных для отображения в tableView
    func retrieveInitialData()
    
    ///Запрос погоды
    func fetchWeather(_ request: WeatherModels.Fetch.Request)
    
    ///Удаление погоды
    func deleteCity(_ request: WeatherModels.Delete.Request)
}


final class WeatherModuleInteractor: NSObject, WeatherModuleDadaSource {
    
    //MARK: - Public properties
    
    var presenter: WeatherModulePresentationLogic!
    
    lazy var dataFetcher: DataFetcher = NetworkDataFetcher()
    lazy var locationManager = LocationWorker(delegate: self)
    lazy var imageWorker = ImageWorker()
    lazy var coreDataWorker = CoreDataWorker()
    
    
    //MARK: - Pivate methods
    
    private func fetchWeatherWithLocation() {
        guard let location = locationManager.exposedLocation else {
            print("Location is nil")
            return
        }
        locationManager.getPlace(for: location) { [weak self] (placemark) in
            guard let self = self, let city = placemark?.locality?.applyingTransform(.toLatin, reverse: false) else { return }
            self.coreDataWorker.createCityEntity(CityModel(cityName: city))
            self.dataFetcher.fetchWeather(searchTerm: city) { [weak self] weather in
                self?.presenter.presentLoading(isActive: false)
                guard let iconID = weather?.weather.first?.icon else { return }
                self?.imageWorker.getImage(with: iconID) { [weak self] (data, error) in
                    guard let iconData = data else { return }
                    let icon = UIImage(data: iconData)
                    self?.presenter.presentWeather(WeatherModels.Fetch.Response(weather: weather, icon: icon, errorMessage: nil))
                    self?.presenter.presentLoading(isActive: false)
                }
            }
        }
    }
}


// MARK: - Weather Module Business Logic

extension WeatherModuleInteractor: WeatherModuleBusinessLogic {
    func retrieveInitialData() {
        let frc = coreDataWorker.retrieveCityEntitiesFetchController()
        self.presenter.presentInitialData(WeatherModels.FetchInitialData.Response(fetchRequestController: frc))
    }
    
    func handleViewReady() {
        presenter.presentLoading(isActive: true)
        //start location search
        fetchWeatherWithLocation()
    }
    
    func fetchWeather(_ request: WeatherModels.Fetch.Request) {
        presenter.presentLoading(isActive: true)
        dataFetcher.fetchWeather(searchTerm: request.city) { [weak self] weather in
            guard let iconID = weather?.weather.first?.icon else { return }
            self?.imageWorker.getImage(with: iconID) { [weak self] (data, error) in
                guard let iconData = data else { return }
                let icon = UIImage(data: iconData)
                self?.presenter.presentWeather(WeatherModels.Fetch.Response(weather: weather, icon: icon, errorMessage: nil))
                self?.presenter.presentLoading(isActive: false)
            }
        }
    }
    
    func deleteCity(_ request: WeatherModels.Delete.Request) {
        let response = WeatherModels.Delete.Response(city: request.city, index: request.index)
        presenter.presentWithoutDeletedCity(response)
        coreDataWorker.deleteCityEntity(request.city)
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
