//
//  WeatherRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol WeatherRouterInput {
    
}

protocol WeatherRouterDataSource: class {
    
}

protocol WeatherRouterDataDestination: class {
    
}

class WeatherRouter: WeatherRouterInput {
    
    weak var viewController: WeatherViewController!
    weak private var dataSource: WeatherRouterDataSource!
    weak var dataDestination: WeatherRouterDataDestination!
    
    init(viewController: WeatherViewController, dataSource: WeatherRouterDataSource, dataDestination: WeatherRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Navigation
    
    // MARK: Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
}
