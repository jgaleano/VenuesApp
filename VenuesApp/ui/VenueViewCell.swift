//
//  VenueViewCell.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class VenueViewCell: UITableViewCell {
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var distancesLbl: UILabel!
    
    func setVenue(venueObj: VenueItemViewModel) {
        titleLbl.text = venueObj.venueSourceObj!.name
        addressLbl.text = venueObj.venueSourceObj!.location?.address
        distancesLbl.text = String(format: "%.2f", venueObj.distanceCalculated)
        venueObj.venueImage.bind {
            self.venueImage.image = $0
        }
    }
}

