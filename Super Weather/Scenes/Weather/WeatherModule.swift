//
//  WeatherModule.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

final class WeatherModule {
    
    static func build(viewController: WeatherModuleViewController) {
        
        let presenter = WeatherModulePresenter()
        presenter.view = viewController
        
        let interactor = WeatherModuleInteractor()
        interactor.presenter = presenter
        
        let router = WeatherModuleRouter()
        router.viewController = viewController
        router.dataSource = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
