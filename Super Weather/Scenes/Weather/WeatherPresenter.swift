//
//  WeatherPresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 30.06.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

final class WeatherPresenter {
    
    // MARK: - Properties
    
    weak var view: WeatherViewInput?
    var interactor: WeatherInteractorInput?
    var router: WeatherRouterInput?
    
}


// MARK: - WeatherViewOutput
extension WeatherPresenter: WeatherViewOutput {
    func viewIsReady() {
        interactor?.loadInfo()
    }
    
    func closePage() {
        router?.closeModule()
    }
}


// MARK: - WeatherInteractorOutput
extension WeatherPresenter: WeatherInteractorOutput {
    func infoLoaded() {
        print("Info Loaded")
        print("Update View")
        view?.updateView()
    }
}
