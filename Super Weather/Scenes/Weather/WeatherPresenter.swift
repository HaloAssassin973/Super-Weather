//
//  WeatherPresenter.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


protocol WeatherPresenterInput {
    
}

protocol WeatherPresenterOutput: NSObject {
    
}

class WeatherPresenter: WeatherPresenterInput {
    
    weak var output: WeatherPresenterOutput?
    
    // MARK: - Presentation logic
    
}
