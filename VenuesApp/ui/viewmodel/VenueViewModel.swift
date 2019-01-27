//
//  VenueViewModel.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit
import CoreLocation

class VenueViewModel: NSObject {
    
    var listVenues: BoxBinding<[VenueItemViewModel]?> = BoxBinding([])
    
    private var venueApiManager:VenueApiManager?
    private var gpsManager: GPSManager
    var currentLocation: CLLocationCoordinate2D {
        return gpsManager.currentLocation.value!
    }
    
    override init() {
        venueApiManager = VenueApiManager.sharedInstance
        gpsManager = GPSManager.sharedInstance
    }
}

extension VenueViewModel {
    func getVenues() -> Void {
        listVenues.value = []
        gpsManager.currentLocation.bind {
            print("GPS Location is: \(String(describing: $0?.latitude)),\(String(describing: $0?.longitude))")
            self.getVenuesFromService(gpsLatitude: ($0?.latitude)!, gpsLongitude: ($0?.longitude)!)
        }
        gpsManager.startGPS()
    }
    
    func getVenuesFromService(gpsLatitude: Double, gpsLongitude: Double) {
        venueApiManager?.searchVenuesByLocation(gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, onSuccess: { venues in
            var venuesMod = self.calculateDistanceAndTransformToViewObject(venues: venues)
            venuesMod.sort(by: {$0.distanceCalculated < $1.distanceCalculated})
            self.listVenues.value = venuesMod
        }, onFailure: { error in
            print(error.localizedDescription)
        })
    }
}

private extension VenueViewModel {
    func calculateDistanceAndTransformToViewObject(venues: [Venue]) -> [VenueItemViewModel] {
        var venuesView: [VenueItemViewModel] = []
        let currentLocation = CLLocation(latitude: gpsManager.currentLocation.value?.latitude ?? 0, longitude: gpsManager.currentLocation.value?.longitude ?? 0);
        for index in 0..<venues.count {
            let venueLocation = CLLocation(latitude: ((venues[index].location?.gpsLatitude)!), longitude: (venues[index].location?.gpsLongitude)!)
            venuesView.append(VenueItemViewModel(venueSourceObj: venues[index], distanceCalculated: currentLocation.distance(from: venueLocation)))
        }
        return venuesView
    }
}
