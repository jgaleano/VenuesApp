//
//  GeneralConfig.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/28/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class GeneralConfig {
    
    struct GeneralConstants {
        static let PlistName = "GeneralConfig"
        static let ClientId = "clientId"
        static let ClientSecret = "clientSecret"
        static let VersionDate = "versionDate"
        static let GoogleServices = "googleServices"
    }
    
    private let generalRoot: NSDictionary
    static let sharedInstance = GeneralConfig()
    
    init() {
        let bundle = Bundle.main.path(forResource: GeneralConstants.PlistName, ofType: "plist")
        generalRoot = NSDictionary.init(contentsOfFile: bundle!)!
    }
    
    func getClientId() -> String {
        return generalRoot.object(forKey: GeneralConstants.ClientId) as! String
    }
    
    func getClientSecret() -> String {
        return generalRoot.object(forKey: GeneralConstants.ClientSecret) as! String
    }
    
    func getVersionDate() -> String {
        return generalRoot.object(forKey: GeneralConstants.VersionDate) as! String
    }
    
    func getGoogleServicesKey() -> String {
        return generalRoot.object(forKey: GeneralConstants.GoogleServices) as! String
    }
}
