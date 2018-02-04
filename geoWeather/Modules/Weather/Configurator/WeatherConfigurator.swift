//
//  WeatherWeatherConfigurator.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit
import Swinject
import CoreLocation

class WeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? WeatherViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeatherViewController) {

        let r = ApplicationAssembly.assembler.resolver as! Container
        
        r.register(WeatherRouter.self) { r in
            let weatherRouter = WeatherRouter()
            weatherRouter.listRouter = r.resolve(ListRouter.self)
            weatherRouter.weatherViewController = viewController
            return weatherRouter
            }
        
        r.register(ListRouter.self) { _ in ListRouter() }
                    .initCompleted { r, listRouter in
                        listRouter.weatherRouter = r.resolve(WeatherRouter.self)
                }
        
        
        let presenter = WeatherPresenter()
        presenter.view = viewController
        presenter.router = r.resolve(WeatherRouter.self)
        presenter.locationService = r.resolve(LocationService.self)

        let interactor = WeatherInteractor()
        interactor.output = presenter
        interactor.weatherService = r.resolve(WeatherService.self)
        interactor.dataManager = r.resolve(ListDataManager.self)


        presenter.interactor = interactor
        viewController.output = presenter
    }

}

