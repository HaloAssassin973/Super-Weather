//
//  CitySearchModulePresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchModulePresentationLogic: class {
    
    ///описание
    func presentLoading(isActive: Bool)
    
    ///описание
    func presentWeather(_ response: CitySearchModels.Fetch.Response)
    
    ///описание
    func presentWeatherModule()
}

final class CitySearchModulePresenter {
    
    weak var view: CitySearchModuleDisplayLogic?

}

extension CitySearchModulePresenter: CitySearchModulePresentationLogic {
    func presentWeather(_ response: CitySearchModels.Fetch.Response) {
        
    }
    
    func presentWeatherModule() {

    }
    
    func presentLoading(isActive: Bool) {
        
    }
    
}
