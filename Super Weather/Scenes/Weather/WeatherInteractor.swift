//
//  WeatherInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


protocol WeatherInteractorInput {
    
}

protocol WeatherInteractorOutput {
    
}

protocol WeatherDataSource {
    
}

protocol WeatherDataDestination {
    
}

class WeatherInteractor: WeatherInteractorInput, WeatherDataSource, WeatherDataDestination {
    
    var output: WeatherInteractorOutput?
    
    // MARK: Business logic
    

}
