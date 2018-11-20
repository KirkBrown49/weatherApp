//
//  api manager.swift
//  weatherApp
//
//  Created by Kirk Brown on 11/14/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct ApiManager {
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
        
    }
    
    private let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
     func getWeather(at location: Location,onComplete: @escaping (WeatherData?,Error?) ->Void ){
        let root = "https://api.darksky.net/forecast"
        let key = Apikeys.darkSkySecret
        let url = "\(root)/\(key)/\(location.latitude),\(location.longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onComplete(weatherData, nil)
                } else {
                    onComplete(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onComplete(nil,error)
            }
        }
    }
    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + Apikeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
                
                print(json)
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
        
        
    }

}
