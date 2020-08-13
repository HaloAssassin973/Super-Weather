//
//  CitySearchInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import CoreLocation

protocol CitySearchInteractorInput {
    
}

protocol CitySearchInteractorOutput {
    func presentWeather(_ response: CitySearchScene.FetchWeather.Response)
}

protocol CitySearchDataSource {
    
}

protocol CitySearchDataDestination {
    
}

class CitySearchInteractor: NSObject, CitySearchInteractorInput, CitySearchDataSource, CitySearchDataDestination, CLLocationManagerDelegate {
    
    var output: CitySearchInteractorOutput?
    private var dataFetcher: DataFetcherWorker?
    private var locationManager: LocationWorker!
    // MARK: - Business logic
    

}

extension CitySearchInteractor: CitySearchViewControllerOutput {
    
    
    func fetchWeather(_ request: CitySearchScene.FetchWeather.Request) {
        dataFetcher = NetworkDataFetcher()
        dataFetcher?.fetchWeather(searchTerm: request.city) { data in
            self.output?.presentWeather(CitySearchScene.FetchWeather.Response(weather: data))
        }
    }
    
    func fetchWeatherWithLocation() {
        locationManager = LocationWorker(client: self)
        dataFetcher = NetworkDataFetcher()
        guard let location = locationManager.exposedLocation else {
            print("Location is nil")
            return
        }
        locationManager.getPlace(for: location) { (placemark) in
            guard let city = placemark?.locality?.applyingTransform(.toLatin, reverse: false) else { return }
            self.dataFetcher?.fetchWeather(searchTerm: city) { weather in
                self.output?.presentWeather(CitySearchScene.FetchWeather.Response(weather: weather))
            }
        }
    }
}

extension CitySearchInteractor: CitySearchRouterDataSource, CitySearchRouterDataDestination {
    
}
