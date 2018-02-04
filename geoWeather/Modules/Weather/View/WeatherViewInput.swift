//
//  WeatherWeatherViewInput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

protocol WeatherViewInput: class {

    /**
        @author sapgv
        Setup initial state of the view
    */

    var location: Location? {get set}
    func setupInitialState()
    func updateView(_ weather: Weather)
}
