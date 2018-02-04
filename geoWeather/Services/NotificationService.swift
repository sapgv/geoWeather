//
//  NotificationService.swift
//  iWeather
//
//  Created by Гриша on 13.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI
import CoreLocation

let requestIdentifier = "SampleRequest" //identifier is to cancel the notification request

class NotificationService: NSObject, LocationServiceDelegate, WeatherServiceDelegate {
    
    var weatherService: WeatherService!
    var isFirstLaunch = true

    func didUpdateLocation(_ location: CLLocation, _ locationName: String) {
        
        print("new location is \(locationName)")
        if isFirstLaunch {
            isFirstLaunch = false
            return
        }
        
        weatherService.retrieveWeatherInfo(location, locationName) { (weather, error) in
            
            DispatchQueue.main.async(execute: {
                
                if let unwrappedError = error {
                    self.didFetchWeather(unwrappedError)
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                let sLocation = Location(name: locationName, lat: location.coordinate.latitude, lon: location.coordinate.latitude)
                self.didFetchWeather(sLocation, unwrappedWeather)
                
            })
            
        }
        
    }
    
    override init() {
        
    }
    
    // MARK: WeatherServiceDelegate
    
    func didFetchWeather(_ location: Location, _ weather: Weather) {
        notify(weather)
    }
    
    func didFetchWeather(_ error: SWError) {
        // TO DO handler error
    }
    
    func notify(_ weather: Weather) {
        
        print("notification will be triggered in five seconds..")
        
        let content = UNMutableNotificationContent()
        content.title = weather.location
        content.body = "The temperature is \(weather.temperature)"
        content.sound = UNNotificationSound.default()
        
        // Deliver the notification in five seconds.
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                print(error?.localizedDescription)
            }
        }
        
        
    }
    
    
}


extension NotificationService:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}
