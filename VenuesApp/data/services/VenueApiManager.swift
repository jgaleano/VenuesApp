//
//  VenueApiManager.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit
import Alamofire

struct ServicesResultConstants {
    static let statusCodes = 200..<300
}

class VenueApiManager {
    static let sharedInstance = VenueApiManager()
    let servicesConfig: ServicesConfig
    
    init() {
        servicesConfig = ServicesConfig.sharedInstance
    }
}

typealias VenueSucccessClosure = ([VenueApiObj]) -> Void
typealias ErrorClosure = (Error) -> Void
typealias ImageSuccessClosure = (UIImage) -> Void
extension VenueApiManager {
    func searchVenuesByLocation(gpsLatitude: Double, gpsLongitude: Double, onSuccess: @escaping(VenueSucccessClosure), onFailure: @escaping(ErrorClosure)) -> Void {
        
        let url : String = servicesConfig.getSearchUrl(gpsLatitud: gpsLatitude, gpsLongitude: gpsLongitude)
        print("URL request: \(url)")
        
        Alamofire.request(url).validate(statusCode:ServicesResultConstants.statusCodes).responseJSON { response in
            switch response.result {
            case .success:
                let responseData = response.data
                let decoder = JSONDecoder()
                do {
                    let jsonResponse = try decoder.decode(VenuesApiObj.self, from: responseData!)
                    onSuccess(jsonResponse.venues!)
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
    
    func downloadImageFromVenue(venue: VenueApiObj, onSuccess: @escaping(ImageSuccessClosure), onFailure: @escaping(Error)->Void) -> Void {
        let url : String = servicesConfig.getPhotosUrl(idVenue: venue.id!)
        print("URL request: \(url)")
        
        Alamofire.request(url).validate(statusCode:ServicesResultConstants.statusCodes).responseJSON { response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        //onFailure(error)
                        print(error)
                    }
                    return
                }
                let photoUrl = self.getPhoUrl(json: json)
                print("URL PHOTO")
                print(photoUrl)
                if photoUrl == "" {
                    return
                }
                Alamofire.request(photoUrl).responseData { response in
                    if let image = response.result.value {
                        print("Image response OK")
                        onSuccess(UIImage(data: image, scale: 1.0)!)
                    } else {
                        print("ERROR")
                        //onFailure(<#Error#>)
                    }
                    
                }
                break
            case .failure(let error):
                onFailure(error)
                break
            }
        }
    }
    
    func getPhoUrl(json: [String:Any]) -> String {
        let a = json["response"] as! [String: Any]
        let b = a["photos"] as? [String: Any]
        let c = b?["items"] as? [Dictionary<String,AnyObject>]
        if c?.count == 0 {
            print("PHOTOS EMPTY")
            return ""
        }
        let photoJson = c?[0]
        let prefix = photoJson?["prefix"] as! String
        let suffix = photoJson?["suffix"] as! String
        let width = photoJson?["width"] as! Int
        let height = photoJson?["height"] as! Int
        return prefix+String(width)+"x"+String(height)+suffix
    }
}
