//
//  WeatherModulePresentaionLogicSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 30.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
@testable import Super_Weather

final class WeatherModulePresentionLogicSpy: WeatherModulePresentationLogic {
    
    
    // MARK: - Public Properties
    
    private(set) var isCalledPresentLoading = false
    
    
    // MARK: - Public Methods
    
    func presentLoading(isActive: Bool) {
        isCalledPresentLoading = true
    }
    
    func presentWeather(_ response: WeatherModels.Fetch.Response) {
        
    }
    
    func presentCitySearch() {
        
    }
    
    func presentInitialData(_ response: WeatherModels.FetchInitialData.Response) {
        
    }
    
    func presentWithoutDeletedCity(_ response: WeatherModels.Delete.Response) {
        
    }
    
    func presentError(_ errorResponse: WeatherModels.Error.ErrorResponse) {
        
    }
}

