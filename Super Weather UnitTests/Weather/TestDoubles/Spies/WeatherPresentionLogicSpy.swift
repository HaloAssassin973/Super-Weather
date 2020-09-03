//
//  WeatherPresentionLogicSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 30.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
@testable import Super_Weather

final class WeatherPresentionLogicSpy: WeatherModulePresentationLogic {
    
    
    // MARK: - Private Properties
    
    private(set) var isCalledPresentLoading = false
    private(set) var isCalledPresentWeather = false
    private(set) var isCalledPresentCitySearch = false
    private(set) var isCalledPresentInitialData = false
    private(set) var isCalledPresentWithoutDeletedCity = false
    private(set) var isCalledPresentError = false
    
    
    // MARK: - Public Methods
    
    func presentLoading(isActive: Bool) {
        isCalledPresentLoading = true
    }
    
    func presentWeather(_ response: WeatherModels.Fetch.Response) {
        isCalledPresentWeather = true
    }
    
    func presentCitySearch() {
        isCalledPresentCitySearch = true
    }
    
    func presentInitialData(_ response: WeatherModels.FetchInitialData.Response) {
        isCalledPresentInitialData = true
    }
    
    func presentWithoutDeletedCity(_ response: WeatherModels.Delete.Response) {
        isCalledPresentWithoutDeletedCity = true
    }
    
    func presentError(_ errorResponse: WeatherModels.Error.ErrorResponse) {
        isCalledPresentError = true
    }
}

