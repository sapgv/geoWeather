//
//  WeatherWeatherRouter.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//
import SwinjectStoryboard

class WeatherRouter: WeatherRouterInput {
    
    var listRouter: ListRouterInput!
    var weatherViewController: UIViewController!
    
    func presentListInterfaceForLocation(_ location: Location?) {
        
        listRouter.presentListInterfaceForLocation(location, fromViewController: weatherViewController)
        
    }
    

}
