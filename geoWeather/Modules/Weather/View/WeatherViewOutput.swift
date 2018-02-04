//
//  WeatherWeatherViewOutput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//
import CoreLocation

protocol WeatherViewOutput: LocationServiceDelegate {

    /**
        @author sapgv
        Notify presenter that view is ready
    */

    func viewIsReady()
    func requestLocation()
    func showListWeatherForLocation(_ location: Location?)
    
}
