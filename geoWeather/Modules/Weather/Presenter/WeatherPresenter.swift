//
//  WeatherWeatherPresenter.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import CoreLocation

typealias WeatherInteractorOutputDelegate = WeatherInteractorOutput & WeatherServiceDelegate

class WeatherPresenter: WeatherModuleInput, WeatherViewOutput, WeatherInteractorOutputDelegate {
        
    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!
    var locationService: LocationService!
    
    // MARK: WeatherViewOutput
    
    func didUpdateLocation(_ location: CLLocation, _ locationName: String) {        
        interactor?.fetchWeatherForLocation(location, locationName)
    }
    
    func showListWeatherForLocation(_ location: Location?) {
        router.presentListInterfaceForLocation(location)
    }
    
    // MARK: WeatherInteractorOutput
    
    func didFetchWeather(_ location: Location, _ weather: Weather) {
        view.location = location
        view.updateView(weather)
    }
    
    func didFetchWeather(_ error: SWError) {
        
    }

    func viewIsReady() {
        locationService.locationManager.delegate = locationService
        locationService.delegate = self
        locationService.startLocalService()
    }
    
    func requestLocation() {
        locationService.locationManager.requestLocation()
    }
    
    
}
