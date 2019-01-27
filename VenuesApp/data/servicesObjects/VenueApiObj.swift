//
//  VenueApiObj.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/26/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

struct Venue: Decodable {
    var id: String?
    var name: String?
    var location: Location?
    var photoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        id = try? container.decode(String.self, forKey: .id)
        location = try? container.decode(Location.self, forKey: .location)
    }
}
