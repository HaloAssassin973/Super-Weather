//
//  WeatherInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 30.06.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol WeatherInteractorInput {
    func loadInfo()
}

protocol WeatherInteractorOutput: AnyObject {
    func infoLoaded()
}

final class WeatherInteractor {
    
    weak var presenter: WeatherInteractorOutput?
}


// MARK: - WeatherInteractorInput
extension WeatherInteractor: WeatherInteractorInput {
    
    func loadInfo() {
        print("Info load")
        presenter?.infoLoaded()
    }
}
