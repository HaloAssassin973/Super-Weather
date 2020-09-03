//
//  ImageWorker.swift
//  Super Weather
//
//  Created by Игорь Силаев on 22.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation

final class ImageWorker {
    
    func getImage(with id: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png")
        guard let imageURL = url else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}


