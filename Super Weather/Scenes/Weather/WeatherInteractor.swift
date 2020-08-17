//
//  WeatherInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import CoreLocation

protocol WeatherInteractorInput {
    
}

protocol WeatherInteractorOutput {
    func presentWeather(_ response: WeatherScene.FetchWeather.Response)
}

protocol WeatherDataSource {
    
}

protocol WeatherDataDestination {
    
}

class WeatherInteractor: NSObject, WeatherInteractorInput, WeatherDataSource, WeatherDataDestination, CLLocationManagerDelegate {
    
    //MARK: - Properties
    
    var output: WeatherInteractorOutput?
    private var dataFetcher: DataFetcherWorker?
    private var locationManager: LocationWorker!
    
    // MARK: - Business logic
    
}

extension WeatherInteractor: WeatherViewControllerOutput {
    
    func fetchWeather(_ request: WeatherScene.FetchWeather.Request) {
        dataFetcher = NetworkDataFetcher()
        dataFetcher?.fetchWeather(searchTerm: request.city) { data in
            self.output?.presentWeather(WeatherScene.FetchWeather.Response(weather: data))
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
                self.output?.presentWeather(WeatherScene.FetchWeather.Response(weather: weather))
            }
        }
    }
}

extension WeatherInteractor: WeatherRouterDataSource, WeatherRouterDataDestination {
    
}
