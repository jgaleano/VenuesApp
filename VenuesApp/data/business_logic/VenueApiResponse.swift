//
//  VenueApiResponse.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

struct VenueApiResponse: Codable {
    var response: Response
    var meta: Meta
}

struct Meta: Codable {
    var code: Int
    var requestId: String
}

struct Response: Codable {
    var venues: [Venue]
}

struct Venue: Codable {
    var id: String
    var name: String
    var location: Location
}

struct Location: Codable {
    var distance: Int
    var distanceCalculated: Double?
    var lng: Double
    var lat: Double
    var address: String?
    var city: String?
}
