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
    
    override init() {
        venueApiManager = VenueApiManager.sharedInstance
    }

}

extension VenueViewModel {
    func getVenues() -> Void {
        venueApiManager?.searchVenuesByLocation(gpsLatitude: 40.7, gpsLongitude: -74, onSuccess: { venues in
            print("Service response: \(venues)");
        }, onFailure: { error in
            print(error.localizedDescription)
        })
    }
}
