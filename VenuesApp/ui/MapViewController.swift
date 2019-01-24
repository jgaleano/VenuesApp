//
//  MapViewController.swift
//  VenuesApp
//
//  Created by Julio Laptop on 1/24/19.
//  Copyright © 2019 Julio Galeano. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: ViewController {

    public var currentLocation: CLLocationCoordinate2D?
    public var listVenues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.currentLocation?.latitude ?? 0), longitude: Double(self.currentLocation?.longitude ?? 0), zoom: 20.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        addVenueMarkers(mapView: mapView)
    }
}

extension MapViewController {
    private func addVenueMarkers(mapView: GMSMapView) {
        for venue in self.listVenues {
            let markerSquirt = GMSMarker()
            markerSquirt.position = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            markerSquirt.title = venue.name
            markerSquirt.snippet = venue.location.address
            markerSquirt.map = mapView
            //markerSquirt.icon = UIImage(named: "007 Squirtle")
        }
    }
}
