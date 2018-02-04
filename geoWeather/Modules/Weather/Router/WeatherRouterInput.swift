//
//  WeatherWeatherRouterInput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol WeatherRouterInput: class {

    var listRouter: ListRouterInput!  { get set }
    
    func presentListInterfaceForLocation(_ location: Location?)
    
}
