//
//  CitySearchModuleRouter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchModuleRoutingLogic: class {
    
    ///Показ ошибки
    func showErrorAlert(message: String, completion: ((Bool) -> Void)?)
    
    ///Переход к экрану с отображением погоды
    func routeToWeatherModule()
}


final class CitySearchModuleRouter {
    
    weak var viewController: CitySearchModuleViewController?
    weak var dataSource: CitySearchModuleDadaSource?
}


// MARK: - City Search Module Routing Logic

extension CitySearchModuleRouter: CitySearchModuleRoutingLogic {
    
    func showErrorAlert(message: String, completion: ((Bool) -> Void)? = nil) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController?.present(errorAlert, animated: true, completion: nil)
    }
    
    func routeToWeatherModule() {
        viewController?.dismiss(animated: true, completion: {
            self.viewController?.navigationController?.popViewController(animated: true)
        })
    }
}
