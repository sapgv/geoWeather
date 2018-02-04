//
//  WeatherWeatherViewController.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherViewInput, UITableViewDelegate, UITableViewDataSource {
   
    var output: WeatherViewOutput!
    var location: Location?
    var forecasts: [Forecast] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet var noContentView: UIView!
    @IBOutlet var strongView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        cleareWeatherView()
        configureView()
        configureTableView()
        
    }

    @objc func updateWeather() {
        output?.requestLocation()
    }
    
    @objc func listWeather() {
        guard let location = location else {
            return
        }
        output?.showListWeatherForLocation(location)
    }

    // MARK: WeatherViewInput
    
    func setupInitialState() {
    }
    
    func cleareWeatherView() {
        
        self.locationLabel.text = ""
        self.tempLabel.text = ""
        self.iconLabel.text = ""
        self.descriptionLabel.text = ""
    }
    
    func updateView(_ weather: Weather) {
        
        if let tempInt = Int(weather.temperature) {
            let fahrenheit = min(max(0, (tempInt*9)/5 + 32),99)
            let gradientImageName = "gradient\(Int(floor(Double(fahrenheit / 10)))).png"
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: gradientImageName)!)
        }
        
        self.locationLabel.text = weather.location
        self.tempLabel.text = weather.temperature
        self.iconLabel.text = weather.iconText
        self.descriptionLabel.text = weather.description
        
        self.forecasts = weather.forecasts
    }
    
}

extension WeatherViewController {
    
    func configureView() {
        
        navigationItem.title = "geoWeather"
        
        let updateItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(WeatherViewController.updateWeather))
        updateItem.tintColor = .white
        
        let listItem = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(WeatherViewController.listWeather))
        listItem.tintColor = .white

        navigationItem.leftBarButtonItem = updateItem
        navigationItem.rightBarButtonItem = listItem
        
    }
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ForecastCell
        
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        let forecast = forecasts[indexPath.row]
        cell?.dayLabel.text = forecast.dayOfWeek
        cell?.dayTempLabel.text = forecast.dayTemperature
        cell?.nightTempLabel.text = forecast.nightTemperature
        cell?.iconLabel.text = forecast.iconText
        
        return cell!
    }
}

