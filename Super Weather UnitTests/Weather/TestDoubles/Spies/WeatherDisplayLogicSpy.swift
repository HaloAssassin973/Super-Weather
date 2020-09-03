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
    private(set) var isCalledDisplayActivityIndicator = false
    private(set) var isCalledDisplayError = false
    private(set) var isCalledDisplayWeather = false
    private(set) var isCalledDisplayCitySearch = false
    private(set) var isCalledDisplayInitialData = false
    private(set) var isCalledDisplayWithoutDeleted = false
    
    // MARK: - Public Methods
    
    func displayActivityIndicator(isActive: Bool) {
        isCalledDisplayActivityIndicator = true
    }
    
    func displayError(_ errorModel: WeatherModels.Error.ErrorModel) {
        isCalledDisplayError = true
    }
    
    func displayWeather(_ viewModel: WeatherModels.Show.ViewModel) {
        isCalledDisplayWeather = true
    }
    
    func displayCitySearch() {
        isCalledDisplayCitySearch = true
    }
    
    func displayInitialData(_ viewModel: WeatherModels.FetchInitialData.ViewModel) {
        isCalledDisplayInitialData = true
    }
    
    func displayWithoutDeleted(_ viewModel: WeatherModels.Delete.ViewModel) {
        isCalledDisplayWithoutDeleted = true
    }
    
}
