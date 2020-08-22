//
//  CitySearchModels.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


struct CitySearchModels {
    
    struct Fetch {
        
        struct Request {
            let city: String
        }
        
        struct Response {
            let weather: WeatherAPI?
            let errorMessage: String?
        }
    }
}
