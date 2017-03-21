//
//  WeatherService.swift
//  WeatherMap
//
//  Created by Senior Node on 22.03.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import GoogleMaps

class WeatherService {
    let API: String
    
    init() {
        API = "http://api.openweathermap.org/data/2.5/weather?APPID=\(ApiConfig.OPEN_WEATHER_API_KEY)&units=metric&q="
    }
    
    func getWeather(city: String, marker: GMSMarker) {
        let query = "\(API)\(city)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        Alamofire.request(query!).responseJSON{ response in
            let json = JSON(data: response.data!)
            var weatherText = "Температура: \(json["main"]["temp"]) C\n"
            weatherText += "Влажность: \(json["main"]["humidity"]) %\n"
            weatherText += "Давление: \(json["main"]["pressure"])"
            marker.snippet = weatherText
        }
    }
}
