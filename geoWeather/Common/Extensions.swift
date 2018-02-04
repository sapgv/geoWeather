//
//  Extensions.swift
//  iweather
//
//  Created by Гриша on 26.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

let dateFormatter: DateFormatter = {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    return dateFormatter
}()

extension UIViewController {
    
    func showAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension Date {
    
    func stringFromDate() -> String {
        
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM'T'HH:mm:ss")
        return dateFormatter.string(from: self)
        
    }
}
