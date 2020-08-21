//
//  WeatherModuleRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol WeatherModuleRoutingLogic: class {
    
    ///описание
    func showErrorAlert(message: String, completion: ((Bool) -> Void)?)
    
    ///описание
    func routeToCitySearch()
}


final class WeatherModuleRouter {
    
    weak var viewController: WeatherModuleViewController?
    weak var dataSource: WeatherModuleDadaSource?
}


// MARK: - Weather Module Routing Logic

extension WeatherModuleRouter: WeatherModuleRoutingLogic {
    
    func showErrorAlert(message: String, completion: ((Bool) -> Void)? = nil) {
        //do showErrorAlert
    }
    
    func routeToCitySearch() {
        //do routeToCitySearch
    }
}
