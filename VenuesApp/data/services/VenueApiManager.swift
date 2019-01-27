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
    private let baseURL = "https://api.foursquare.com/v2/venues/"
    private let searchPath = "search?ll="
    private let photosPath = "/photos?"
    //private let authenticationURL = "&client_id=2LOOZAAWUUZHO2VJFLXRBE43DVYJEV4LD2W3KNHBQD13R51K&client_secret=OOQX0TPP1KSTCPGUJTOZGZCJNDOVTGQ0DYZ1RK5GBNF01HB1&v=20190121"
    //juliocsarin@hotmail.com
//    private let authenticationURL = "&client_id=KAKCU5144RYNFGE5EQZBQANRSOMNO4A5IX4BGIZQHTCIM5BI&client_secret=VZMJAWA2GQ4XAI2V1YWOFHAPWKYXSLKA24HOH3VTMQNXOFJB&v=20190121"
    //tulionectar@yahoo.com
//    private let authenticationURL = "&client_id=SL3JKM4XMIR5SEPVT05DYVRC1VZPBHVPHRBPSMXUXBOXBVVL&client_secret=4SP02FLA2Q3BMZ4SC4KSHMHW5XJSHKHDNGJ2AI04WMX1J3OM&v=20190121"
    //LadyAguilar260@gmail.com
    private let authenticationURL = "&client_id=WDV1HPA0RYTU21AYMA3RTWW2SUNUKTMQ5ULZD2A1AUWRWVTB&client_secret=WULBGGCNSJHIBGJO2IOAAP3N3O3K5OAON0M3PAXNYOMG13FP&v=20190121"
    static let sharedInstance = VenueApiManager()
}

typealias VenueSucccessClosure = ([VenueApiObj]) -> Void
typealias ErrorClosure = (Error) -> Void
typealias ImageSuccessClosure = (UIImage) -> Void
extension VenueApiManager {
    func searchVenuesByLocation(gpsLatitude: Double, gpsLongitude: Double, onSuccess: @escaping(VenueSucccessClosure), onFailure: @escaping(ErrorClosure)) -> Void {
        
        let url : String = String("\(baseURL)\(searchPath)\(String(gpsLatitude)),\(String(gpsLongitude))\(authenticationURL)")
        print("URL request: \(url)")
        
        Alamofire.request(url).validate(statusCode:200..<300).responseJSON { response in
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
        let url : String = baseURL + venue.id! + photosPath + authenticationURL
        print("URL request: \(url)")
        
        Alamofire.request(url).validate(statusCode:200..<300).responseJSON { response in
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
                let a = json["response"] as! [String: Any]
                let b = a["photos"] as? [String: Any]
                let c = b?["items"] as? [Dictionary<String,AnyObject>]
                if c?.count == 0 {
                    print("PHOTOS EMPTY")
                    return
                }
                let photoJson = c?[0]
                let prefix = photoJson?["prefix"] as! String
                let suffix = photoJson?["suffix"] as! String
                let width = photoJson?["width"] as! Int
                let height = photoJson?["height"] as! Int
                let photoUrl = prefix+String(width)+"x"+String(height)+suffix
                print("URL PHOTO")
                print(photoUrl)
                
                Alamofire.request(photoUrl).responseData { response in
                    //debugPrint(response)
                    //debugPrint(response.result)
                    
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
}
