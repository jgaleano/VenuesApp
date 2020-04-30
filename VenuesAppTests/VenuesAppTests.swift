//
//  VenuesAppTests.swift
//  VenuesAppTests
//
//  Created by Julio César Galeano García on 30/04/20.
//  Copyright © 2020 Julio Galeano. All rights reserved.
//

import XCTest
@testable import VenuesApp

class VenuesAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let viewModel = ViewModel()
        let result = viewModel.sum(values: [1,2,3])
        XCTAssertEqual(result, 6)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
