//
//  WeatherAssembly.swift
//  Super Weather
//
//  Created by Игорь Силаев on 10.06.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

final class WeatherAssembly {

    static func assembly() -> UIViewController {
        
        let view = WeatherViewController()
        let presenter = WeatherPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = WeatherInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = WeatherRouter(view: view)
        presenter.router = router
        
        return view
    }
}
