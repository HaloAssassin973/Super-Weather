//
//  WeatherPresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


protocol WeatherPresenterInput {

}

protocol WeatherPresenterOutput: AnyObject {
    func printWeather(_ viewModel: WeatherScene.FetchWeather.ViewModel)
}

class WeatherPresenter: WeatherPresenterInput {
    
    weak var output: WeatherPresenterOutput?
    
    // MARK: - Presentation logic

}

extension WeatherPresenter: WeatherInteractorOutput {
    
    func presentWeather(_ response: WeatherScene.FetchWeather.Response) {
        let viewModel = WeatherScene.FetchWeather.ViewModel(weather: response.weather)
        output?.printWeather(viewModel)
    }
}

