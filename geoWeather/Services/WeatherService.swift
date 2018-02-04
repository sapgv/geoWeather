//
//  WeatherService.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

typealias WeatherCompletionHandler = (Weather?, SWError?) -> Void

protocol WeatherServiceDelegate: class {
    
    func didFetchWeather(_ location: Location, _ weather: Weather)
    func didFetchWeather(_ error: SWError)
    
}
protocol WeatherServiceProtocol {
    
    func retrieveWeatherInfo(_ location: CLLocation, _ locationName: String, completionHandler: @escaping WeatherCompletionHandler)
    
}

struct WeatherService: WeatherServiceProtocol {
    
    fileprivate let urlPath = "http://api.openweathermap.org/data/2.5/forecast/daily/"

    func retrieveWeatherInfo(_ location: CLLocation, _ locationName: String, completionHandler: @escaping WeatherCompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(location) else {
            let error = SWError(errorCode: .urlError)
            completionHandler(nil, error)
            return
        }
        
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check network error
            guard error == nil else {
                let error = SWError(errorCode: .networkRequestFailed)
                completionHandler(nil, error)
                return
            }
            
            // Check JSON serialization error
            guard let data = data else {
                let error = SWError(errorCode: .jsonSerializationFailed)
                completionHandler(nil, error)
                return
            }
            
            guard let json = try? JSON(data: data) else {
                let error = SWError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
                return
            }
            
            // Get temperature, location and icon and check parsing error
            
            let forecasts = self.getForecasts(json)
            guard let _ = json["city"]["name"].string,
                let dayTemperature = forecasts.first?.dayTemperature,
                let nightTemperature = forecasts.first?.nightTemperature,
                let description = forecasts.first?.description,
                let weatherIcon = forecasts.first?.iconText
                else {
                    let error = SWError(errorCode: .jsonParsingFailed)
                    completionHandler(nil, error)
                    return
            }
            
            var temperature = ""
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            if hour > 6  && hour < 20 {
                temperature = dayTemperature
            }
            else {
                temperature = nightTemperature
            }
            
            var weatherBuilder = WeatherBuilder()
            weatherBuilder.location = locationName
            weatherBuilder.dayTemperature = dayTemperature
            weatherBuilder.nightTemperature = nightTemperature
            weatherBuilder.temperature = temperature
            weatherBuilder.iconText = weatherIcon
            weatherBuilder.description = description
            weatherBuilder.forecasts = forecasts
            
            completionHandler(weatherBuilder.build(), nil)
        }
        
        task.resume()
    }
    
    fileprivate func getForecasts(_ json: JSON) -> [Forecast] {
        
        var forecasts: [Forecast] = []
        
        for index in 0...6 {
            
            guard let dayTemp = json["list"][index]["temp"]["day"].double,
                let nightTemp = json["list"][index]["temp"]["night"].double,
                let rawDateTime = json["list"][index]["dt"].double,
                let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                let forecastIcon = json["list"][index]["weather"][0]["icon"].string,
                let forecastDescription = json["list"][index]["weather"][0]["description"].string
                else {
                    break
            }
            
            let country = json["city"]["country"].string
            let forecastDayTemperature = Temperature(country: country!, openWeatherMapDegrees: dayTemp)
            let forecastNightTemperature = Temperature(country: country!, openWeatherMapDegrees: nightTemp)
            let forecastTimeString = ForecastDateTime(rawDateTime).shortTime
            let dayOfWeek = ForecastDateTime(rawDateTime).dayOfWeek
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forcastIconText = weatherIcon.iconText
            
            let forecast = Forecast(time: forecastTimeString,
                                    dayOfWeek: dayOfWeek,
                                    iconText: forcastIconText,
                                    dayTemperature: forecastDayTemperature.degrees,
                                    nightTemperature: forecastNightTemperature.degrees,
                                    description: forecastDescription)
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    fileprivate func generateRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        
        // get appId from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let appId = parameters!["OWMAccessToken"]! as! String
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
    }
    
    
}

