//
//  geoWeatherDataTest.swift
//  geoWeatherTests
//
//  Created by Гриша on 05.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import XCTest
import CoreLocation
@testable import geoWeather

class geoWeatherDataTest: XCTestCase {
    
    var location: Location!
    var coreDataStore: CoreDataStore = CoreDataStore()
    var listDataManager: ListDataManager = ListDataManager()
    var weatherService: WeatherService = WeatherService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        listDataManager.coreDataStore = coreDataStore
        // Put setup code here. This method is called before the invocation of each test method in the class.
        location = Location(name: "London", lat: 51.509865, lon: -0.118092)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFindLocations() {
        self.measure() {
            
            self.listDataManager.findList(location) {
                locations in
            }
        }
    }
    
    func testFetchWeather() {
        
        let coreLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        self.measure {
            weatherService.retrieveWeatherInfo(coreLocation, location.name) { (weather, error) in
                
            }
            
        }
    }
    
}
