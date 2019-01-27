//
//  GPSManager.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit
import CoreLocation

class GPSManager: NSObject {
    private let locationManager = CLLocationManager()
    var currentLocation: BoxBinding<CLLocationCoordinate2D?> = BoxBinding(nil)
    static let sharedInstance: GPSManager = GPSManager()
    
    private override init() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension GPSManager {
    func startGPS() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}

extension GPSManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            self.currentLocation.value = location.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            print("Location authorization is denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
