//
//  WeatherBusinessLogicSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 03.09.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
@testable import Super_Weather

final class WeatherBusinessLogicSpy: WeatherModuleBusinessLogic {
    
    
    // MARK: - Private Properties
    
    private(set) var isCalledHandleViewReady = false
    private(set) var isCalledRetrieveInitialData = false
    private(set) var isCalledFetchWeather = false
    private(set) var isCalledDeleteCity = false
    private(set) var isCalledAddButtonTapped = false
    
    // MARK: - Public Methods
    
    func handleViewReady() {
        isCalledHandleViewReady = true
    }
    
    func retrieveInitialData() {
        isCalledRetrieveInitialData = true
    }
    
    func fetchWeather(_ request: WeatherModels.Fetch.Request) {
        isCalledFetchWeather = true
    }
    
    func deleteCity(_ request: WeatherModels.Delete.Request) {
        isCalledDeleteCity = true
    }
    
    func addButtonTapped() {
        isCalledAddButtonTapped = true
    }

}
