//
//  ForecastDateTime.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct ForecastDateTime {
    let rawDate: Double
    
    init(_ date: Double) {
        rawDate = date
    }
    
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: rawDate)
        return dateFormatter.string(from: date)
    }
    
}
