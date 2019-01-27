//
//  LocationCalculations.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/26/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import CoreLocation

class LocationCalculations {
}

extension LocationCalculations {
    func calculateDistanceFromLocationPoints(currentLocation: CLLocation, venueLocation: CLLocation) -> Double {
        return currentLocation.distance(from: venueLocation)
    }
}
