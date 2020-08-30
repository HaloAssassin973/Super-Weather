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
    
    struct FetchInitialData {
        struct Response {
            let fetchRequestController: NSFetchedResultsController<CityEntity>
        }
        struct ViewModel {
            let cityNames: [String]
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
    
    struct Delete {
        struct Request {
            let city: String
            let index: Int
        }
        struct Response {
            let city: String
            let index: Int
        }
        struct ViewModel {
            let city: String
            let index: Int
        }
    }
    
    struct Show {
        struct ViewModel {
            let cityName: String
            let temperature: String
            let description: String?
            let image: UIImage?
        }
    }
    
    struct Error {
        struct ErrorResponse {
            let message: String
        }
        struct ErrorModel {
            let message: String
        }
    }
}
