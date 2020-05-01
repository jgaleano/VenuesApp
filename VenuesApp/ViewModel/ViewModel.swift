//
//  ViewModel.swift
//  VenuesApp
//
//  Created by Julio César Galeano García on 30/04/20.
//  Copyright © 2020 Julio Galeano. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    func sum(values: [Int]) -> Int {
        var result = 0
        for value in values {
            result += value
        }
        return result
    }
    
    func sum(value1: Int, value2: Int) -> Int {
        return value1+value2
    }
}
