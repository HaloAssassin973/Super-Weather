//
//  LocationWorker.swift
//  Super Weather
//
//  Created by Игорь Силаев on 10.07.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationWorker: NSObject {
    
    //MARK: - Property
    private let locationManager = CLLocationManager()
    var exposedLocation: CLLocation? {
        return locationManager.location
    }
    
    //MARK: - Inizilization
    init(delegate: CLLocationManagerDelegate? = nil) {
        super.init()
        self.locationManager.delegate = delegate
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: - Methods
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "en_US")
        if #available(iOS 11.0, *) {
            geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
                
                if let error = error {
                    print("*** Error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error: placemark is nil")
                    completion(nil)
                    return
                }
                
                completion(placemark)
            }
        } else {
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                
                if let error = error {
                    print("*** Error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error: placemark is nil")
                    completion(nil)
                    return
                }
                
                completion(placemark)
            }
        }
    }
}
