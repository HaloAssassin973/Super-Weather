//
//  WeatherModels.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import UIKit
import CoreData

struct WeatherModels {
    
    struct FRC {
        struct Response {
            let frc: NSFetchedResultsController<CityEntity>
        }
    }
    
    struct Fetch {
        
        struct Request {
            let city: String
        }
        
        struct Response {
            let weather: WeatherAPI?
            let icon: UIImage?
            let errorMessage: String?
        }
    }
    
    struct GetCities {
        
        struct Response {
            let city: [CityModel]
        }
        
        struct ViewModel {
            let citiesNames: [String]
        }
    }
    
    struct Show {
        
        struct ViewModel {
            let cityName: String
            let temperature: String
            let description: String?
            let image: UIImage?
        }
        
        struct ErrorModel {
            let message: String
        }
    }
}
