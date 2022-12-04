//
//  ViewController.swift
//  WeatherApp
//
//  Created by Max on 28.11.2022.
//

import UIKit
import WeatherKit

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
        
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=68ff194557295b5eb3a2a5abcb3ef98e"
//        let urlString2 = "https://api.openweathermap.org/data/2.5/weather?appid=68ff194557295b5eb3a2a5abcb3ef98e&lat=44.34&lon=10.99"
        
//        let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=68ff194557295b5eb3a2a5abcb3ef98e&")
//        let fullURL = URL(string: "lat=44.34&lon=10.99", relativeTo: baseURL)
//
//        let sessionConfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfiguration)
//
//        let request = URLRequest(url: fullURL!)
//        let dataTask = session.dataTask(with: fullURL!) { data, response, error in
//
//        }
//
//        dataTask.resume()
        
        
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
