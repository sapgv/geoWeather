//
//  WeatherWeatherInteractorOutput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherInteractorOutput: class {

    func didUpdateLocation(_ location: CLLocation, _ locationName: String)
//    func didFetchWeather(_ weather: Weather)
//    func didFetchWeather(_ error: SWError)
    
}
