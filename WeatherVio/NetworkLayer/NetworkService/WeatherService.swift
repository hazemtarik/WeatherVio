//
//  FetchingWeather.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


class WeatherService {
    
    
    static let shared = WeatherService()
    
    
    func fetchWeather(lat: Double, long: Double, unit: String, completion: @escaping(Result<Weather,ErrorHandler>)->()) {
        NetworkEngine.fetchData(serviceEndPoint: WeatherEndPoints.Weather(lat: lat, long: long, unit: unit)) { (result) in
            completion(result)
        }
    }
    
    
    func fetchSavedWeather(lat: Double, long: Double, unit: String, completion: @escaping(Result<SavedWeather,ErrorHandler>)->()) {
        NetworkEngine.fetchData(serviceEndPoint: WeatherEndPoints.SavedWeather(lat: lat, long: long, unit: unit)) { (result) in
            completion(result)
        }
    }
    
}
