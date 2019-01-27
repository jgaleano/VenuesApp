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
            let _ = $0!
            self.tableView.reloadData()
        }
    }
    
    @IBAction func callServiceClick() {
        venueViewModel.getVenues()
    }
    
    @IBAction func photosClick() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapViewController {
            let mvc = segue.destination as? MapViewController
            mvc?.listVenues = venueViewModel.listVenues.value ?? []
            mvc?.currentLocation = venueViewModel.currentLocation
        }
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
        
        //Download image
        if venue?.venueImage.value == nil {
            cell.venueImage.image = UIImage(named: "FoursquareLogo")!
            venue?.downloadVenueImage(venueSourceObj: venue!.venueSourceObj!)
        }
        else {
            cell.venueImage.image = venue?.venueImage.value
        }
        return cell
    }
}
