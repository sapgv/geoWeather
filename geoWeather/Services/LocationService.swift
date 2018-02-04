//
//  LocationService.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func didUpdateLocation(_ location: CLLocation, _ locationName: String)
}

protocol LocationGeocodeDelegate {
    func didGeocodeName(_ name: String, _ location: CLLocation)
}
class LocationService: NSObject, CLLocationManagerDelegate {
    
    var delegate: LocationServiceDelegate?
    var managerDelegate: CLLocationManagerDelegate?
    var geocodeDelegate: LocationGeocodeDelegate?
    
    var geoCoder: CLGeocoder?
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyHundredMeters
        m.delegate = managerDelegate
        return m
    }()
    
    override init() {
        super.init()
        managerDelegate = self
    }
    
    func startLocalService() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    func startBackgroundService() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.distanceFilter = CLLocationDistance(3000)
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            geoCoder?.reverseGeocodeLocation(location) {
                (placemarks, error) -> Void in
                let placemark = placemarks?.first
                
                if let locationName = placemark?.locality {
                    self.delegate?.didUpdateLocation(location, locationName)
                }

            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error obtain location \(error)")
    }
    
}
