//
//  VenuesAppTests.swift
//  VenuesAppTests
//
//  Created by Julio Laptop on 1/28/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import XCTest

@testable import VenuesApp
import CoreLocation

class VenuesAppTests: XCTestCase {
    
    var locationCalculations: LocationCalculations!

    override func setUp() {
        locationCalculations = LocationCalculations()
    }

    override func tearDown() {
        locationCalculations = nil
    }

    func testcalculateDistanceFromLocationPoints() {
        
        let locacionSource = CLLocation(latitude: 37.7873589, longitude: -122.408227)
        let locationDestiny = CLLocation(latitude: 37.78741507686055, longitude: -122.40819240702244)
        
        let distance = locationCalculations.calculateDistanceFromLocationPoints(currentLocation: locacionSource, venueLocation: locationDestiny)
        print(distance)
        
        XCTAssertEqual(distance, 6.94, "Distance calculated is wrong")
    }

    func testPerformanceExample() {
        self.measure {
        }
    }

}
