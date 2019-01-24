//
//  ViewController.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var callServiceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func callServiceClick() {
        let venueViewModel = VenueViewModel()
        venueViewModel.getVenues()
    }
}

