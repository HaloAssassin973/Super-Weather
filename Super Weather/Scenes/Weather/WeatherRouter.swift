//
//  WeatherRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 30.06.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol WeatherRouterInput {
    func closeModule()
}

final class WeatherRouter {
    
    // MARK: - Properties
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}


// MARK: - WeatherRouterInput
extension WeatherRouter: WeatherRouterInput {
    
    func closeModule() {
        print("Module close")
    }
}
