//
//  VenueLocationApiObj.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/26/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

struct Location: Decodable {
    var gpsLatitude: Double?
    var gpsLongitude: Double?
    var address: String?
    var city: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case lat
        case lng
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address = try? container.decode(String.self, forKey: .address)
        gpsLatitude = try? container.decode(Double.self, forKey: .lat)
        gpsLongitude = try? container.decode(Double.self, forKey: .lng)
        city = try? container.decode(String.self, forKey: .city)
    }
}
