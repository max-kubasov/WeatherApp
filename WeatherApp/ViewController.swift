//
//  ViewController.swift
//  WeatherApp
//
//  Created by Max on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = WeatherIconManager.ClearDay.image
        let currentWeather = CurrentWeather(temperatury: 10.0, appereantTemperature: 5.0, humidity: 30, pressure: 750, icon: icon)
        updateCurrentWeather(currentWeather: currentWeather)
    }

    func updateCurrentWeather(currentWeather: CurrentWeather) {
        
        self.imageView.image = currentWeather.icon
        self.locationLabel.text = "Kiev of the capital of Ukraine"
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.humidityLabel.text = currentWeather.humidityString
        self.appearentTemperatureLabel.text = currentWeather.appereantTemperatureString
    }
}
