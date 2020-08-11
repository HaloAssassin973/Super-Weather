//
//  CitySearchConfigurator.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CitySearchInteractor: CitySearchViewControllerOutput, CitySearchRouterDataSource, CitySearchRouterDataDestination {
}

extension CitySearchPresenter: CitySearchInteractorOutput {
}

class CitySearchConfigurator {
    // MARK: Object lifecycle
    
    static let sharedInstance = CitySearchConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: CitySearchViewController) {
        
        let presenter = CitySearchPresenter()
        presenter.output = viewController
        
        let interactor = CitySearchInteractor()
        interactor.output = presenter
        
        let router = CitySearchRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
