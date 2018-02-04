//
//  ListListRouterInput.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

protocol ListRouterInput: class {

    weak var weatherRouter: WeatherRouterInput! { get set }
    
    func presentListInterfaceForLocation(_ location: Location?, fromViewController viewController: UIViewController)
    
}
