//
//  WeatherConfigurator.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

final class WeatherConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = WeatherConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: WeatherViewController) {
        
        let presenter = WeatherPresenter()
        presenter.output = viewController
        
        let interactor = WeatherInteractor()
        interactor.output = presenter
        
        let router = WeatherRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
