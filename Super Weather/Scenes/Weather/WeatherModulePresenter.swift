//
//  WeatherModulePresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol WeatherModulePresentationLogic: class {
    
    ///описание
    func presentLoading(isActive: Bool)
    
    ///описание
    func presentWeather(_ response: WeatherModels.Fetch.Response)
    
    ///описание
    func presentCitySearch()
    
    ///описание
    func presentCities(_ response: WeatherModels.GetCities.Response)
}


final class WeatherModulePresenter {
    
    weak var view: WeatherModuleDisplayLogic?
}


// MARK: - Weather Module Presentation Logic

extension WeatherModulePresenter: WeatherModulePresentationLogic {
    func presentLoading(isActive: Bool) {
        view?.displayActivityIndicator(isActive: isActive)
    }
    
    func presentWeather(_ response: WeatherModels.Fetch.Response) {
        if let message = response.errorMessage {
            let model = WeatherModels.Show.ErrorModel(message: message)
            view?.displayError(model)
            return
        }
        guard let weather = response.weather else {
            let model = WeatherModels.Show.ErrorModel(message: "Somthing went wrong") // переделать на Localizable.strings
            view?.displayError(model)
            return
        }
        let viewModel = WeatherModels.Show.ViewModel(cityName: weather.name,
                                                     temperature: String(format: "%.0f", weather.main.tempCelsius) + "°",
                                                     description: weather.weather.first?.weatherDescription,
                                                     image: response.icon)
        view?.displayWeather(viewModel)
    }
    
    func presentCitySearch() {
        view?.displayCitySearch()
    }
    
    func presentCities(_ response: WeatherModels.GetCities.Response) {
        var cities: [String] = []
        for city in response.city {
            cities.append(city.cityName)
        }
        let viewModel = WeatherModels.GetCities.ViewModel(citiesNames: cities)
        self.view?.displayCities(viewModel)
    }
}
