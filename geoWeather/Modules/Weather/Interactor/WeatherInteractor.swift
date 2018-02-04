//
//  WeatherWeatherInteractor.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//
import CoreLocation

class WeatherInteractor: WeatherInteractorInput {

    weak var output: WeatherInteractorOutputDelegate!
    var weatherService: WeatherService!
    var dataManager: ListDataManager!
    
    func fetchWeatherForLocation(_ location: CLLocation, _ locationName: String) {
        retrieveWeather(location, locationName)
    }
    
    func retrieveWeather(_ location: CLLocation, _ locationName: String) {
        
        weatherService.retrieveWeatherInfo(location, locationName) { (weather, error) in
            
            DispatchQueue.main.async(execute: {
                
                if let unwrappedError = error {
                    self.output.didFetchWeather(unwrappedError)
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                let sLocation = Location(name: locationName, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                self.dataManager.createListData(location, unwrappedWeather)
                self.output.didFetchWeather(sLocation, unwrappedWeather)
                
            })
            
        }
        
    }
}
