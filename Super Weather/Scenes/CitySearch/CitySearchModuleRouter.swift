//
//  CitySearchModuleRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchModuleRoutingLogic: class {
    
    ///описание
    func showErrorAlert(message: String, completion: ((Bool) -> Void)?)
    
    ///описание
    func routeToWeatherModule()
}


final class CitySearchModuleRouter {
    
    weak var viewController: CitySearchModuleViewController?
    weak var dataSource: CitySearchModuleDadaSource?
}


// MARK: - City Search Module Routing Logic

extension CitySearchModuleRouter: CitySearchModuleRoutingLogic {
    
    func showErrorAlert(message: String, completion: ((Bool) -> Void)? = nil) {
        //do showErrorAlert
    }
    
    func routeToWeatherModule() {
        //do routeToWeather
    }
}
