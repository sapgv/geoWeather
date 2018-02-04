//
//  WeatherWeatherInteractorInput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherInteractorInput {

    func fetchWeatherForLocation(_ location: CLLocation, _ locationName: String)
    
}
