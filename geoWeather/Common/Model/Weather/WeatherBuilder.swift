//
//  WeatherBuilder.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct WeatherBuilder {
    var location: String?
    var iconText: String?
    var temperature: String?
    var dayTemperature: String?
    var nightTemperature: String?
    var description: String?
    
    var forecasts: [Forecast]?
    
    func build() -> Weather {
        return Weather(location: location!,
                       iconText: iconText!,
                       temperature: temperature!,
                       dayTemperature: dayTemperature!,
                       nightTemperature: nightTemperature!,
                       description: description!,
                       forecasts: forecasts!)
    }
}
