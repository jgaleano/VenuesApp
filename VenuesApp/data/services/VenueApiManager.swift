//
//  VenueApiManager.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit
import Alamofire

class VenueApiManager: NSObject {
    private let baseURL = "https://api.foursquare.com/v2/venues/search?ll="
    private let authenticationURL = "&client_id=2LOOZAAWUUZHO2VJFLXRBE43DVYJEV4LD2W3KNHBQD13R51K&client_secret=OOQX0TPP1KSTCPGUJTOZGZCJNDOVTGQ0DYZ1RK5GBNF01HB1&v=20190121"
    static let sharedInstance = VenueApiManager()
}

extension VenueApiManager {
    
    func searchVenuesByLocation(gpsLatitude: Double, gpsLongitude: Double, onSuccess: @escaping([Venue]) -> Void, onFailure: @escaping(Error)->Void) -> Void {
        
        let url : String = baseURL + String(gpsLatitude) + "," + String(gpsLongitude) + authenticationURL
        print("URL request: \(url)")
        
        Alamofire.request(url).validate(statusCode:200..<300).responseJSON { response in
            switch response.result {
            case .success:
                let responseData = response.data
                let decoder = JSONDecoder()
                do {
                    let jsonResponse = try decoder.decode(VenueApiResponse.self, from: responseData!)
                    onSuccess(jsonResponse.response.venues)
                }
                catch {
                    onFailure(error)
                }
                break
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
