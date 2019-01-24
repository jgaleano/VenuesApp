//
//  VenueViewModel.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit


class VenueViewModel: NSObject {
    
    private var venueApiManager:VenueApiManager?
    private var gpsManager: GPSManager
    
    override init() {
        venueApiManager = VenueApiManager.sharedInstance
        gpsManager = GPSManager.sharedInstance
    }
}

extension VenueViewModel {
    func getVenues() -> Void {
        gpsManager.currentLocation.bind {
            print("GPS Location is: \(String(describing: $0?.latitude)),\(String(describing: $0?.longitude))")
            self.getVenuesFromService(gpsLatitude: ($0?.latitude)!, gpsLongitude: ($0?.longitude)!)
        }
        gpsManager.startGPS()
    }
    
    func getVenuesFromService(gpsLatitude: Double, gpsLongitude: Double) {
        venueApiManager?.searchVenuesByLocation(gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, onSuccess: { venues in
            print("Service response: \(venues)");
        }, onFailure: { error in
            print(error.localizedDescription)
        })
    }
}
