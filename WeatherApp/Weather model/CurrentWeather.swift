//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Max on 30.11.2022.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperatury: Double
    let appereantTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrentWeather {
    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
    
    var humidityString: String {
        return "\(Int(humidity)) %"
    }
    
    var temperatureString: String {
        return "\(Int(temperatury))˚C"
    }
    
    var appereantTemperatureString: String {
        return "\(Int(appereantTemperature))˚C"
    }
}
