//
//  weatherData.swift
//  weatherApp
//
//  Created by Kirk Brown on 11/16/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    enum Condition: String {
        case clearDay  = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        //computed property that selects a emoji passed on the value of our condition
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌕 "
            case .rain:
                return "🌧"
            case .snow, .sleet:
                return "🌨"
            case .wind:
                return "💨"
            case .fog:
                return "🌫"
            case .cloudy:
                return "☁️"
            case.partlyCloudyDay:
                return "⛅️"
            case .partlyCloudyNight:
                return "🌓"
                
            }
        }
    }
    enum WeatherDataKeys:String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    let temperature:Double
    let highTemperature:Double
    let lowTemperature:Double
    let condition:Condition
    
    //designated initializer
    init(temperature:Double,highTemperature:Double,lowTemperature:Double,condition:Condition) {
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.temperature = temperature
        self.condition = condition
    }
    
    convenience init?(json:JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double
            else {
                 print("Couldn't get temperature")
                return nil
        }
        guard let highTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
            print("Couldn't get high temp")
            return nil
        }
        
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
            print("Couldn't get low temp")
            return nil
        }
        guard let conditionString = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else {
            print("couldn't get condition")
            return nil
        }
        
        print(conditionString)
        
        guard let condition = Condition(rawValue: conditionString)else {
            print("couldn't init condition")
            return nil
        }
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition)
    }
}

