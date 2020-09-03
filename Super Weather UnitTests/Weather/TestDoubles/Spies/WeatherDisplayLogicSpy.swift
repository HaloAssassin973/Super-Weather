//
//  WeatherDisplayLogicSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 03.09.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
@testable import Super_Weather

final class WeatherDisplayLogicSpy: WeatherModuleDisplayLogic {
    
    // MARK: - Private Properties
    
    // MARK: - Public Methods
    
    func displayActivityIndicator(isActive: Bool) {
        
    }
    
    func displayError(_ errorModel: WeatherModels.Error.ErrorModel) {
        
    }
    
    func displayWeather(_ viewModel: WeatherModels.Show.ViewModel) {
        
    }
    
    func displayCitySearch() {
        
    }
    
    func displayInitialData(_ viewModel: WeatherModels.FetchInitialData.ViewModel) {
        
    }
    
    func displayWithoutDeleted(_ viewModel: WeatherModels.Delete.ViewModel) {
        
    }
    
}
