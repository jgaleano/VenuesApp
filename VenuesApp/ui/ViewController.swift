//
//  ViewController.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var venueViewModel = VenueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        venueViewModel.listVenues.bind { [unowned self] in
            print($0!)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func callServiceClick() {
        venueViewModel.getVenues()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (venueViewModel.listVenues.value?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venueViewModel.listVenues.value?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueViewCell") as! VenueViewCell
        cell.setVenue(venueObj: venue!)
        return cell
    }
}

