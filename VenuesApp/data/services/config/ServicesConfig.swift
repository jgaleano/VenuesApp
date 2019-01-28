//
//  ServicesConfig.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/28/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit


struct ServicesConstants {
    static let PlistName = "ServicePaths"
    static let BaseUrl = "baseUrl"
    static let SearchPath = "searchPath"
    static let LocationVariable = "locationVariable"
    static let PhotosPath = "photosPath"
    static let ClientId = "clientId"
    static let ClientSecret = "clientSecret"
    static let VersionDate = "versionDate"
    
}

class ServicesConfig {
    
    private let servicesRoot: NSDictionary
    static let sharedInstance = ServicesConfig()
    private let generalConfig: GeneralConfig
    private let baseUrl: String?
    
    init() {
        let bundle = Bundle.main.path(forResource: ServicesConstants.PlistName, ofType: "plist")
        servicesRoot = NSDictionary.init(contentsOfFile: bundle!)!
        generalConfig = GeneralConfig.sharedInstance
        baseUrl = servicesRoot.object(forKey: ServicesConstants.BaseUrl) as? String
        
    }
}

extension ServicesConfig {
    
    private func getAuthenticationUrl() -> String {
        let clientId = servicesRoot.object(forKey: ServicesConstants.ClientId) as? String
        let clientSecret = servicesRoot.object(forKey: ServicesConstants.ClientSecret) as? String
        let versionDate = servicesRoot.object(forKey: ServicesConstants.VersionDate) as? String
        return "\(clientId!)=\(generalConfig.getClientId())&\(clientSecret!)=\(generalConfig.getClientSecret())&\(versionDate!)=\(generalConfig.getVersionDate())"
    }
    
    func getSearchUrl(gpsLatitud: Double, gpsLongitude:Double) -> String {
        let searchPath = servicesRoot.object(forKey: ServicesConstants.SearchPath) as? String
        let locationVariable = servicesRoot.object(forKey: ServicesConstants.LocationVariable) as? String
        
        return "\(baseUrl!)\(searchPath!)?\(locationVariable!)=\(gpsLatitud),\(gpsLongitude)&\(self.getAuthenticationUrl())"
    }
    
    func getPhotosUrl(idVenue: String) -> String {
        let photosPath = servicesRoot.object(forKey: ServicesConstants.PhotosPath) as? String
        return "\(baseUrl!)\(idVenue)/\(photosPath!)?\(self.getAuthenticationUrl())"
    }
}
