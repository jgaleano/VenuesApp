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
    public var listVenues: [VenueItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.currentLocation?.latitude ?? 0), longitude: Double(self.currentLocation?.longitude ?? 0), zoom: 19.0)
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
            markerSquirt.position = CLLocationCoordinate2D(latitude: (venue.venueSourceObj!.location?.gpsLatitude)!, longitude: (venue.venueSourceObj!.location?.gpsLongitude)!)
            markerSquirt.title = venue.venueSourceObj!.name
            markerSquirt.snippet = venue.venueSourceObj!.location?.address
            markerSquirt.map = mapView
        }
    }
}
