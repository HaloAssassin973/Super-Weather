//
//  WeatherModel.swift
//  Super Weather
//
//  Created by Игорь Силаев on 10.07.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation

// MARK: - WeatherAPI
struct WeatherAPI: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    
    var tempCelsius: Double {
        return temp - 273.15
    }
    var tempMinCelsius: Double {
        return tempMin - 273.15
    }
    var tempMaxCelsius: Double {
        return tempMax - 273.15
    }
    
//    var tempFahrenheit: Double {
//        return (temp - 273.15) * 1.8 + 32
//    }
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int
    let message: Double?
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

