//
//  ListDataManager.swift
//  geoWeather
//
//  Created by Гриша on 04.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

class ListDataManager: NSObject {
    
    var coreDataStore : CoreDataStore?

    func findList(_ location: Location, completion: (([List]) -> Void)!) {
        
        coreDataStore?.fetchListData(location.name, completionBlock: { entries in
            let listData = self.listDataFromCoreStoreEntries(entries)
            completion(listData)
        })
        
    }

    func listDataFromCoreStoreEntries(_ entries: [_List]) -> [List] {
        
        let listData: [List] = entries.map { entry in
            List(name: entry.name!, lat: entry.lat, lon: entry.lon, date: entry.date!, temp: entry.temp!, icon: entry.icon!)
        }
        return listData
        
    }
    
    func createListData(_ location: CLLocation, _ weather: Weather) {
        
        let list = coreDataStore?.createListData()
        list?.name = weather.location
        list?.date = Date()
        list?.icon = weather.iconText
        list?.lat = location.coordinate.latitude
        list?.lon = location.coordinate.longitude
        list?.temp = weather.temperature
        
        coreDataStore?.save()
        
    }
    
}
