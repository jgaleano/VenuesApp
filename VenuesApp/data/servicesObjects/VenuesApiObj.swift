//
//  VenueApiResponse.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

struct Venues: Decodable {
    var venues: [Venue]?
    
    enum CodingKeys: String, CodingKey {
        case response
        case venues
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        venues = try? response.decode([Venue].self, forKey: .venues)
    }
}
