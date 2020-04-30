//
//  ViewController.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sumBtn: UIButton!
    @IBOutlet weak var sumResultLbl: UILabel!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sumClick(_ sender: Any) {
        sumResultLbl.text = "\(viewModel.sum(values: [1,2,3,4,5,6,7,8,9]))"
    }
}

