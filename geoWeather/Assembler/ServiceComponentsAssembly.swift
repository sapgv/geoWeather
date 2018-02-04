//
//  ServiceComponentsAssembly.swift
//  geoWeather
//
//  Created by Гриша on 04.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import Swinject
import CoreLocation
import UserNotifications

class ServiceComponentsAssembly: Assembly {
    
    func assemble(container: Container) {
        
        
        
        container.register(CoreDataStore.self, factory: {_ in CoreDataStore()})
        
        container.register(CoreDataStore.self, factory: {_ in CoreDataStore()})
        container.register(ListDataManager.self) { r in
            let listDataManager = ListDataManager()
            listDataManager.coreDataStore = r.resolve(CoreDataStore.self)
            return listDataManager
        }
        container.register(WeatherService.self) { _ in
            WeatherService()
            }.inObjectScope(.transient)
        
        container.register(CLGeocoder.self) { _ in
            CLGeocoder()
            }.inObjectScope(.transient)
        
        container.register(LocationService.self) { r in
            let locationService = LocationService()
            locationService.geoCoder = r.resolve(CLGeocoder.self)
            return locationService
            }.inObjectScope(.transient)
        
        //background
        container.register(WeatherService.self, name: "background") { _ in WeatherService() }
        container.register(NotificationService.self) { r in
            let notificationService = NotificationService()
            notificationService.weatherService = r.resolve(WeatherService.self, name: "background")
            return notificationService
        }
        
        container.register(LocationService.self, name: "background") { r in
            let locationService = LocationService()
            locationService.geoCoder = r.resolve(CLGeocoder.self)
            locationService.delegate = r.resolve(NotificationService.self)
            return locationService
        }
    }
    
}
