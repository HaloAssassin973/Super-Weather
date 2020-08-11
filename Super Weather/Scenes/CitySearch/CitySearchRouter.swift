//
//  CitySearchRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchRouterInput {
    
}

protocol CitySearchRouterDataSource: NSObject {
    
}

protocol CitySearchRouterDataDestination: NSObject {
    
}

class CitySearchRouter: CitySearchRouterInput {
    
    weak var viewController: CitySearchViewController!
    weak private var dataSource: CitySearchRouterDataSource!
    weak var dataDestination: CitySearchRouterDataDestination!
    
    init(viewController: CitySearchViewController, dataSource: CitySearchRouterDataSource, dataDestination: CitySearchRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: - Navigation
    
    // MARK: - Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
}
