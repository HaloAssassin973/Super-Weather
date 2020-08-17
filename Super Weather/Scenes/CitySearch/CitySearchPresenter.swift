//
//  CitySearchPresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


protocol CitySearchPresenterInput {
    
}

protocol CitySearchPresenterOutput: AnyObject {
    func printWeather(_ viewModel: CitySearchScene.FetchWeather.ViewModel)
}

class CitySearchPresenter: CitySearchPresenterInput {
    
    weak var output: CitySearchPresenterOutput?
    
    // MARK: - Presentation logic
    
}

extension CitySearchPresenter: CitySearchInteractorOutput {
    
    func presentWeather(_ response: CitySearchScene.FetchWeather.Response) {
        let viewModel = CitySearchScene.FetchWeather.ViewModel(weather: response.weather)
        output?.printWeather(viewModel)
    }
}
