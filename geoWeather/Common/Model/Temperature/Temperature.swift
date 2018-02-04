//
//  Temperature.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct Temperature {
    let degrees: String
    
    init(country: String, openWeatherMapDegrees: Double) {

        //let's use only celsius temperature
        degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees))

        //        if country == "US" {
//            degrees = String(TemperatureConverter.kelvinToFahrenheit(openWeatherMapDegrees))
//        } else {
//            degrees = String(TemperatureConverter.kelvinToCelsius(openWeatherMapDegrees))
//        }
    }
}
