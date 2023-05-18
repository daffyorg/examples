//
//  LocationDataProvider.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation
import CoreLocation
import Combine

public struct Location {
    let city: String?
    let state: String?
    let country: String?
}

public protocol LocationDataProviderProtocol {
    
    var location: AnyPublisher<Location?, Never> { get }
    
    func requestLocation()
    
    // TODO: Add API methods
    
}

class LocationDataProvider: NSObject, CLLocationManagerDelegate, LocationDataProviderProtocol {
    
    // TODO: Implement API methods
   
    var location: AnyPublisher<Location?, Never> {
        locationSubject.eraseToAnyPublisher()
    }
    let locationSubject: CurrentValueSubject<Location?, Never> = CurrentValueSubject(nil)
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            locationManager.requestLocation()
        default:
            break
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let latestLocation = locations.last {
            geocoder.reverseGeocodeLocation(latestLocation) { placemark, error in
                if let placemark = placemark?.last {
                    let geocodedLocation = Location(city: placemark.locality, state: placemark.administrativeArea, country: placemark.country)
                    self.locationSubject.send(geocodedLocation)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Handle Location Error
    }
}
