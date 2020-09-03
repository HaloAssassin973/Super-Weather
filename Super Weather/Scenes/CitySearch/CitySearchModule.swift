//
//  CitySearchModule.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

final class CitySearchModule {
    
    static func build(viewController: CitySearchModuleViewController) {
        
        let presenter = CitySearchModulePresenter()
        presenter.view = viewController
        
        let interactor = CitySearchModuleInteractor()
        interactor.presenter = presenter
        
        let router = CitySearchModuleRouter()
        router.viewController = viewController
        router.dataSource = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
