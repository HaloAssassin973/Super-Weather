//
//  WeatherDataFetcherSpy.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 30.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
@testable import Super_Weather

final class WeatherDataFetcherSpy: DataFetcher {
    
    
    // MARK: - Private Properties
    
    private(set) var isCalledFetchWeather = false
    
    
    // MARK: - Public Methods
    
    func fetchWeather(searchTerm: String, completion: @escaping (WeatherAPI?) -> ()) {
        isCalledFetchWeather = true
    }
    
}
