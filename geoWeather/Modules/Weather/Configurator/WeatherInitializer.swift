//
//  WeatherWeatherInitializer.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class WeatherModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var weatherViewController: WeatherViewController!

    override func awakeFromNib() {

        let configurator = WeatherModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: weatherViewController)
    }

}
