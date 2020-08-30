//
//  DataFetcherWorker.swift
//  Super Weather
//
//  Created by Игорь Силаев on 10.07.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func fetchWeather(searchTerm: String, completion: @escaping (WeatherAPI?) -> ())
}

final class NetworkDataFetcher: DataFetcher {
    
    var networkWorker = NetworkWorker()
    
    func fetchWeather(searchTerm: String, completion: @escaping (WeatherAPI?) -> ()) {
        networkWorker.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: WeatherAPI.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
