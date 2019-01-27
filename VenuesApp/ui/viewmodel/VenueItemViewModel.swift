//
//  VenueViewObj.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/26/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class VenueItemViewModel: NSObject {
    
    //Obj
    var venueSourceObj: Venue?
    var venueImage: BoxBinding<UIImage?> = BoxBinding(nil)
    var distanceCalculated: Double
    
    //ViewModel
    private var venueApiManager:VenueApiManager?
    
    init(venueSourceObj: Venue!, distanceCalculated: Double) {
        venueApiManager = VenueApiManager.sharedInstance
        self.venueSourceObj = venueSourceObj
        self.distanceCalculated = distanceCalculated
    }
}

extension VenueItemViewModel {
    func downloadVenueImage(venueSourceObj: Venue) -> Void {
        venueApiManager!.downloadImageFromVenue(venue: venueSourceObj,  onSuccess: { cellImage in
            DispatchQueue.main.async {
                print("CELL IMAGE LOADED SUCCESS")
                self.venueImage.value = cellImage
            }
        }, onFailure: { error in
            print(error.localizedDescription)
        })
    }
}
