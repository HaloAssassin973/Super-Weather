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
    func presentInitialData(_ response: WeatherModels.FetchInitialData.Response)
    
    ///описание
    func presentWithoutDeletedCity(_ response: WeatherModels.Delete.Response)
    
    ///описание
    func presentError(_ errorResponse: WeatherModels.Error.ErrorResponse)
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
            let model = WeatherModels.Error.ErrorModel(message: message)
            view?.displayError(model)
            return
        }
        guard let weather = response.weather else {
            let model = WeatherModels.Error.ErrorModel(message: "Somthing went wrong") // переделать на Localizable.strings
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
    
    func presentInitialData(_ response: WeatherModels.FetchInitialData.Response) {
        var viewModel: [String] = []
        guard let cities = response.fetchRequestController.fetchedObjects else { return }
        for city in cities {
            if let cityName = city.cityName {
                viewModel.append(cityName)
            }
        }
        
        self.view?.displayInitialData(WeatherModels.FetchInitialData.ViewModel(cityNames: viewModel))
    }
    
    func presentWithoutDeletedCity(_ response: WeatherModels.Delete.Response) {
        let viewModel = WeatherModels.Delete.ViewModel(city: response.city, index: response.index)
        view?.displayWithoutDeleted(viewModel)
    }
    
    func presentError(_ errorResponse: WeatherModels.Error.ErrorResponse) {
        let errorModel = WeatherModels.Error.ErrorModel(message: errorResponse.message)
        view?.displayError(errorModel)
    }
}
