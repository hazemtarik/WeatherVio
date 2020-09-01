//
//  WeatherEndPoint.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


private let WeatherAPPID = ""



// MARK:- Configure URL in different cases -

enum WeatherEndPoints: EndPoint {
    case Weather(lat: Double, long: Double, unit: String)
    case SavedWeather(lat: Double, long: Double, unit: String)
}



extension WeatherEndPoints {
    var scheme: String {
        switch self {
            default:
                return "https"
        }
    }
    var base: String {
        switch self {
            case .Weather, .SavedWeather:
                return "api.openweathermap.org"
        }
    }
    var path: String {
        switch self {
            case .Weather:
                return "/data/2.5/onecall"
            case .SavedWeather:
                return "/data/2.5/weather"
        }
    }
    var method: String {
        switch self {
            default:
                return "GET"
        }
    }
    var parametar: [URLQueryItem] {
        switch self {
            case .Weather(let lat, let long, let unit):
                return [
                    URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "lon", value: "\(long)"),
                    URLQueryItem(name: "exclude", value: "minutely"),
                    URLQueryItem(name: "units", value: unit),
                    URLQueryItem(name: "appid", value: WeatherAPPID)
            ]
            case .SavedWeather(let lat, let long, let unit):
            return [
                    URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "lon", value: "\(long)"),
                    URLQueryItem(name: "units", value: unit),
                    URLQueryItem(name: "appid", value: WeatherAPPID)
            ]
        }
    }
    
}
