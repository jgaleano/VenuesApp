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
    
    func setVenue(venueObj: Venue) {
        //venueImg.image = venueObj.img;
        titleLbl.text = venueObj.name
        addressLbl.text = venueObj.location.address
        distancesLbl.text = String(format: "%.2f", venueObj.location.distanceCalculated!)
    }
}

